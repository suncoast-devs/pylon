class SessionController < ApplicationController
  def new
    redirect_to auth_path(provider: 'github', callback: params[:callback])
  end

  def create
    authentication_data = request.env['omniauth.auth']
    current_user = User.from_omniauth(authentication_data)

    if current_user
      if current_user.needs_profile_image?
        DownloadProfileImageJob.perform_later(user: current_user, url: authentication_data.info.image)
      end

      callback = request.env['omniauth.params']["callback"]

      redirect_to "#{callback}/#{token(current_user)}"
    else
      redirect_to auth_path(provider: 'github')
    end
  end

  def destroy
    render json: { 'token': nil }
  end

  def failure
    # TODO, create failure.html.erb
  end

  private

  def token(user)
    JWT.encode({ sub: user.id }, Rails.application.secrets.secret_key_base)
  end
end
