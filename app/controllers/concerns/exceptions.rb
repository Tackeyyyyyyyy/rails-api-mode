module Exceptions
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :handle_500
    rescue_from ActionController::RoutingError, with: :handle_404
    rescue_from ActiveRecord::RecordNotFound, with: :handle_404
  end

  private

  def handle_404(exception = nil)
    code = error_status_code(:not_found)
    json_response error_message(exception, code), code
  end

  def handle_500(exception = nil)
    code = error_status_code(:internal_server_error)
    json_response error_message(exception, code), code
  end

  def error_message(exception, code)
    { message: exception, staus: Rack::Utils::HTTP_STATUS_CODES[code] }
  end

  def error_status_code(code)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[code]
  end
end
