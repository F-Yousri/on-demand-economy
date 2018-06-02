class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request, :is_verified

  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def is_verified
   if !((AuthorizeApiRequest.new(request.headers).call)[:user].verified==true)
      json_response("you aren't verified")
   end
 
  end
end
