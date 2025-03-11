module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error
    rescue_from StandardError, with: :handle_server_error unless Rails.env.development?
  end

  private

  def render_error(status, error_hash)
    render json: ErrorResponseBlueprint.render_as_json(error_hash, root: :errors),
           status: status
  end

  def record_not_found(exception)
    render_error(
      :not_found,
      { code: :not_found, message: exception.message }
    )
  end

  def handle_bad_request(exception)
    render_error(
      :bad_request,
      {
        code: :bad_request,
        message: "Missing or empty parameter: #{exception.param}"
      }
    )
  end

  def handle_validation_error(exception)
    render_error(
      :unprocessable_entity,
      {
        code: :unprocessable_entity,
        message: exception.record.errors.full_messages.join(", ")
      }
    )
  end

  def handle_server_error(exception)
    render_error(
      :internal_server_error,
      {
        code: :internal_server_error,
        message: "Something went wrong on our end"
      }
    )
  end
end
