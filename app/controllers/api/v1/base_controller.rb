class Api::V1::BaseController < ActionController::Base
  before_action :restrict_access_via_api_token

  private
    def restrict_access_via_api_token
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists? :token => token
      end
    end
end
