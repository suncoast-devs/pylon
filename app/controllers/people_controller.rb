class PeopleController < GraphitiResourceController
  before_action :ensure_admin, except: :redeem

  def redeem
    enrollment = StudentEnrollment.find_by(invitation_code: params[:invitation_code])

    if enrollment
      redirect_to auth_path(provider: "github", callback: params[:callback], invitation_code: enrollment.invitation_code)
    else
      render status: :not_found
    end
  end
end
