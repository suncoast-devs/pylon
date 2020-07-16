class GistsController < ApplicationController
  before_action :ensure_logged_in

  def index
    render json: GithubIssueInterface.gists(current_person).map(&:to_h)
  end
end
