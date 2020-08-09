class GithubInterface
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
end
