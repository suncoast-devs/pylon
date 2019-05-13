class StudentProgressReportsController < GraphitiResourceController
  before_action :ensure_admin, except: [:index, :show]
end
