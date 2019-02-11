class GraphqlController < ApplicationController
  def execute
    uri = URI.parse(request.original_url)
    base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

    variables      = ensure_hash(params[:variables])
    query          = params[:query]
    operation_name = params[:operationName]
    context        = { base_url: base_url, current_user: Rails.env.test? ? User.find(params[:user_id]) : current_user }

    render json: PylonSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def current_user
    @current_user ||= begin
      return nil if request.headers["Authorization"].blank?

      token = request.headers["Authorization"].split(" ").last
      return nil if token.blank?

      payload, _ = JWT.decode(token, Rails.application.secrets.secret_key_base)

      User.find(payload["sub"])
    rescue JWT::VerificationError
      nil
    end
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {error: {message: e.message, backtrace: e.backtrace}, data: {}}, status: 500
  end
end
