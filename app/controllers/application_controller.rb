class ApplicationController < ActionController::API
  include Exceptions

  def json_response(params, code = 200)
    render json: {
        resources: params,
        response_code: code,
    }
  end
end
