class SessionController < ApplicationController
  def new
    redirect_to auth_path(provider: "github", callback: params[:callback])
  end

  def create
    params = request.env["omniauth.params"]
    authentication_data = request.env["omniauth.auth"]

    current_user = User.from_omniauth(authentication_data, params)

    if current_user
      if current_user.needs_profile_image?
        DownloadProfileImageJob.perform_later(user: current_user, url: authentication_data.info.image)
      end

      redirect_to "#{params["callback"]}/#{current_user.token}"
    else
      redirect_to auth_path(provider: "github")
    end
  end

  def destroy
    render json: {'token': nil}
  end

  def failure
    # TODO, create failure.html.erb
  end
end
