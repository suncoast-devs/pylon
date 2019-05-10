class CohortsController < GraphitiResourceController
  before_action :ensure_admin, except: [:index, :show]
end
