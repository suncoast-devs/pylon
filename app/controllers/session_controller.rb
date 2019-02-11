class SessionController < ApplicationController
  def new
    redirect_to auth_path(provider: 'github', callback: params[:callback])
  end

  def create
    current_user = User.from_omniauth(request.env['omniauth.auth'])

    if current_user
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
