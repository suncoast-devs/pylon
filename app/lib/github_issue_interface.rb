class GithubIssueInterface
  GITHUB_MAX_BYTE_SIZE_FOR_ATTACHMENTS = 9_999_999
  GITHUB_CONTENT_TYPE = "image/gif"

  def self.client_for_app
    Octokit.client
  end

  def self.client_for_person(person)
    Octokit::Client.new(access_token: person.access_token)
  end

  def self.no_repo_configured?(person)
    return !person.github.present? || !person.assignments_repo.present?
  end

  def self.assignments_repo_exists?(person)
    if no_repo_configured?(person)
      log(type: :exists, name: person.full_name, message: "No github or assignments repo present")
      return false
    end

    result = client_for_app.repository?("#{person.github}/#{person.assignments_repo}")

    log(type: :exists, github: person.github, repo: person.assignments_repo, result: result)

    result
  rescue Octokit::InvalidRepository, Octokit::Unauthorized => ex
    log(type: :exists, github: person.github, repo: person.assignments_repo, error: ex.message)

    false
  end

  def self.log(data)
    Rails.logger.info "GITHUB: #{data.to_json}"
  end

  def self.update(assignment)
    retries ||= 0

    person = assignment.person

    return false if no_repo_configured?(person)

    repo = "#{person.github}/#{person.assignments_repo}"

    client_for_person(person).update_issue(repo,
                                assignment.issue,
                                assignment.homework.title,
                                assignment.homework.body,
                                {assignee: person.github})

    log(type: :update, github: person.github, repo: repo, assignment: assignment)
  rescue StandardError => ex
    log(type: :update, github: person.github, repo: repo, failure: ex.message)

    retry if ((retries += 1) < 3)
  end

  def self.create(assignment)
    retries ||= 0

    person = assignment.person

    return false if no_repo_configured?(person)

    repo = "#{person.github}/#{person.assignments_repo}"

    issue = client_for_person(person).create_issue(repo,
                                        assignment.homework.title,
                                        assignment.homework.body,
                                        assignee: person.github)

    assignment.update(issue: issue.number)

    log(type: :create, github: person.github, repo: repo, assignment: assignment, issue: issue)
  rescue StandardError => ex
    log(type: :create, github: person.github, repo: repo, failure: ex.message)

    if ((retries += 1) < 3)
      retry
    else
      assignment.destroy
    end
  end

  def self.issues(person)
    return [] if no_repo_configured?(person)

    repo = "#{person.github}/#{person.assignments_repo}"

    log(type: :load_issues, repo: repo)

    client_for_app.
      issues(repo, state: :all).
      map { |issue| issue.to_h.extract!(:number, :state, :title, :closed_at, :comments) }
  rescue Octokit::NotFound, Octokit::InvalidRepository
    []
  end

  def self.comment_for_assignment(assignment)
    raw_json = Net::HTTP.get(URI("https://gifs.suncoast.io/gifs/#{assignment.score}?content_type=#{GITHUB_CONTENT_TYPE}&max_byte_size=#{GITHUB_MAX_BYTE_SIZE_FOR_ATTACHMENTS}"))

    message = "Your homework **#{assignment.homework.title}** was marked: **#{assignment.score_description}**\n\n\n"

    if raw_json
      gif = JSON.load(raw_json)
      message.concat <<-EOF.strip_heredoc
        ![#{gif["caption"]}](#{gif["image"]})
        > &ldquo;#{gif["caption"]}&rdquo;
      EOF
    end

    message
  end

  def self.set_issue_state(assignment)
    retries ||= 0

    person = assignment.person

    return if no_repo_configured?(person)

    repo = "#{person.github}/#{person.assignments_repo}"

    client_for_person(person).update_issue(repo,
                                assignment.issue,
                                {state: assignment.issue_state})

    log(type: :state, github: person.github, repo: repo, assignment: assignment, state: assignment.issue_state)
  rescue StandardError => ex
    log(type: :state, github: person.github, repo: repo, assignment: assignment, state: assignment.issue_state, failure: ex.message)

    retry if ((retries += 1) < 3)
  end

  def self.comment_on_assignment(assignment)
    retries ||= 0

    person = assignment.person

    return if no_repo_configured?(person)

    repo = "#{person.github}/#{person.assignments_repo}"

    message = comment_for_assignment(assignment)

    client_for_person(person).add_comment(repo, assignment.issue, message)

    log(type: :comment, github: person.github, repo: repo, assignment: assignment, message: message)
  rescue StandardError => ex
    log(type: :comment, github: person.github, repo: repo, failure: ex.message)

    retry if ((retries += 1) < 3)
  end
end
