class ApplicationController < ActionController::API
  include Graphiti::Rails
  include Graphiti::Responders

  register_exception Graphiti::Errors::RecordNotFound,
    status: 404

  rescue_from Exception do |e|
    handle_exception(e)
  end

  def current_user
    @current_user ||= begin
      return nil if request.headers["Authorization"].blank?

      token = request.headers["Authorization"].split("=").last.delete('"')
      return nil if token.blank?

      payload, _ = JWT.decode(token, Rails.application.secrets.secret_key_base)

      User.find(payload["sub"])
    rescue JWT::VerificationError
      nil
    end
  end
end
