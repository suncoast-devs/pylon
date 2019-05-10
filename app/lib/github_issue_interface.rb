class GithubIssueInterface
  def self.client(person)
    Octokit::Client.new(access_token: person.access_token)
  end

  def self.assignments_repo_exists?(person)
    result = client(person).list_repos.any? { |repo|
      log(type: :exists_debug, github: person.github, a: repo.name, b: person.assignments_repo)
      repo.name == person.assignments_repo
    }
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
    person = assignment.person

    repo = " #{person.github}/#{person.assignments_repo}"

    log(type: :update, github: person.github, repo: repo, assignment: assignment)

    client(person).update_issue(repo,
                                assignment.issue,
                                assignment.homework.title,
                                assignment.homework.body,
                                assignee: person.github)
  end

  def self.create(assignment)
    person = assignment.person

    repo = "#{person.github}/#{person.assignments_repo}"

    log(type: :create, github: person.github, repo: repo, assignment: assignment)

    issue = client(person).create_issue(repo,
                                        assignment.homework.title,
                                        assignment.homework.body,
                                        assignee: person.github)

    assignment.update(issue: issue.number)
  end

  def self.issues(person)
    repo = "#{person.github}/#{person.assignments_repo}"

    client(person).
      issues(repo, state: :all).
      map { |issue| issue.to_h.extract!(:number, :state, :title, :closed_at, :comments) }
  rescue Octokit::InvalidRepository
    []
  end

  def self.comment_for_assignment(assignment)
    gif = JSON.load(Net::HTTP.get(URI("https://gifs.suncoast.io/gifs/#{assignment.score}")))
    message = <<-EOF.strip_heredoc
      Your homework **#{assignment.homework.title}** was marked: **#{assignment.score_description}**

      ![#{gif["caption"]}](#{gif["image"]})
      > &ldquo;#{gif["caption"]}&rdquo;
      __&mdash; via **[#{gif["contributor"]}](#{gif["url"]})**__
    EOF
  end

  def self.comment_on_assignment(assignment)
    person = assignment.person

    repo = "#{person.github}/#{person.assignments_repo}"

    message = comment_for_assignment(assignment)

    log(type: :comment, github: person.github, repo: repo, assignment: assignment, message: message)

    client(person).add_comment(repo, assignment.issue, message)
  end
end
