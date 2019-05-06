class AttendanceRecordsController < GraphitiResourceController
  before_action :ensure_admin, except: :index
end
