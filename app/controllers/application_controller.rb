class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  # called before every action on controllers
 

  attr_reader :current_user
  before_action :cors_set_access_control_headers
  def cors_set_access_control_headers
  		headers['Access-Control-Allow-Origin'] = '*'
	end
  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def is_verified
   if !((AuthorizeApiRequest.new(request.headers).call)[:user].verified==true)
      json_response({message: Message.account_not_verified})
   end
 
  end
end
