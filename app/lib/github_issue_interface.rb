class GithubIssueInterface
  def self.update(person, assignment)
    client = Octokit::Client.new(access_token: person.access_token)

    client.update_issue("#{person.github}/#{person.assignments_repo}",
      assignment.issue,
      assignment.homework.title,
      assignment.homework.body,
      assignee: person.github)
  end

  def self.create(person, assignment)
    client = Octokit::Client.new(access_token: person.access_token)

    issue = client.create_issue("#{person.github}/#{person.assignments_repo}",
                     assignment.homework.title,
                     assignment.homework.body,
                     assignee: person.github)

    assignment.update(issue: issue.number)
  end

  def self.issues(person)
    client = Octokit::Client.new(access_token: person.access_token)

    client.
      issues("#{person.github}/#{person.assignments_repo}", state: :all).
      map { |issue| issue.to_h.extract!(:number, :state, :title, :closed_at, :comments) }
  rescue Octokit::InvalidRepository
    []
  end

  def self.comment_on_assignment(assignment)
    person = assignment.person

    gif = JSON.load(Net::HTTP.get(URI("https://gifs.suncoast.io/gifs/#{assignment.score}")))
    message = <<-EOF.strip_heredoc
      Your homework was marked: **#{assignment.score_description}**

      ![#{gif["caption"]}](#{gif["image"]})
      > &ldquo;#{gif["caption"]}&rdquo;
      __&mdash; via **[#{gif["contributor"]}](#{gif["url"]})**__
    EOF

    client = Octokit::Client.new(access_token: person.access_token)
    client.add_comment("#{person.github}/#{person.assignments_repo}", assignment.issue, message)
  end
end