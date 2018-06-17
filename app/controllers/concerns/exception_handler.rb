module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :twenty
    rescue_from ExceptionHandler::AuthenticationError, with: :twenty
    rescue_from ExceptionHandler::MissingToken, with: :twenty
    rescue_from ExceptionHandler::InvalidToken, with: :twenty

    rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
  #no error status for mobile devise
  def twenty(e)
    json_response({ message: e.message })
  end
end
