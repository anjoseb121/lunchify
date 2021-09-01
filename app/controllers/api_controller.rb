class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  include Api::ExceptionHandler
end
