class GithubInterface
  def self.anonymous_client
    Octokit::Client.new
  end

  def self.client_for_person(person)
    Octokit::Client.new(access_token: person.access_token)
  end

  def self.repositories(person)
    client_for_person(person).repositories.sort_by(&:pushed_at).reverse
  rescue Octokit::NotFound, Octokit::InvalidRepository
    []
  end

  def self.gists(person)
    client_for_person(person).gists.sort_by(&:updated_at).reverse
  rescue Octokit::NotFound, Octokit::InvalidRepository
    []
  end

  def self.handbook_assignment_names
    anonymous_client.contents("suncoast-devs/handbook", path: "assignments").map(&:name).select { |name| File.extname(name) == ".md" }
  end

  def self.handbook_assignment_content(assignment_name)
    content = Base64.decode64(anonymous_client.contents("suncoast-devs/handbook", path: "assignments/#{assignment_name}.md").content).force_encoding(Encoding::UTF_8)
    parsed = FrontMatterParser::Parser.new(:md).call(content)

    { front_matter: parsed.front_matter, content: parsed.content }
  end
end
