# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error
    rescue_from StandardError, with: :handle_server_error if Rails.env.production?
    rescue_from Doorkeeper::Errors::DoorkeeperError, with: :handle_unauthorized_access
  end

  private

  def render_error(status, error_hash)
    render json: ErrorResponseBlueprint.render_as_json(error_hash, root: :errors),
           status: status
  end

  def record_not_found(exception)
    render_error(
      :not_found,
      error_payload(:not_found, exception.message)
    )
  end

  def handle_bad_request(exception)
    render_error(
      :bad_request,
      error_payload(:bad_request, "Missing or empty parameter: #{exception.param}")
    )
  end

  def handle_validation_error(exception)
    render_error(
      :unprocessable_entity,
      error_payload(:unprocessable_entity, exception.record.errors.full_messages.join(', '))
    )
  end

  def handle_server_error(_exception)
    render_error(
      :internal_server_error,
      error_payload(:internal_server_error, 'Something went wrong on our end')
    )
  end

  def handle_unauthorized_access(exception)
    render_error(
      :unauthorized,
      error_payload(:unauthorized, exception.message)
    )
  end

  def handle_forbidden_access
    render_error(
      :forbidden,
      error_payload(:forbidden, 'You are not authorized to perform this action')
    )
  end

  def error_payload(code, message)
    { code: code, message: message }
  end
end
