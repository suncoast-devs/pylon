class RepositoriesController < ApplicationController
  before_action :ensure_logged_in

  def index
    render json: GithubIssueInterface.repositories(current_person).map(&:to_h)
  end
end
