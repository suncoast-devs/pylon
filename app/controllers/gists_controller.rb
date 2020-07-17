class GistsController < ApplicationController
  before_action :ensure_logged_in

  def index
    render json: GithubInterface.gists(current_person).map(&:to_h)
  end
end
