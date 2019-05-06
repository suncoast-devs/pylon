class CohortDatesController < GraphitiResourceController
  before_action :ensure_admin

  def create
    render status: 401, json: { error: "NOPE" }
  end
end
