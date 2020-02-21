# frozen_string_literal: true

module ResponseHelper
  def render_created(resource)
    render_resource(resource, :created)
  end

  def render_ok(resource)
    render_resource(resource, :ok)
  end

  def render_unprocessable_entity(message = 'Unprocessable entity')
    render json: { errors: message }, status: :unprocessable_entity
  end

  def render_not_found(message = 'Not found')
    render json: { errors: message },
           status: :not_found
  end

  def render_bad_request(message = 'Bad request')
    render json: { errors: message },
           status: :bad_request
  end

  def render_forbidden(message = 'Forbidden')
    render json: { errors: message },
           status: :forbidden
  end

  def render_unauthorized(message = 'Login to continue')
    render json: { errors: message },
           status: :unauthorized
  end

  def render_no_content
    render json: { success: true }, status: :no_content
  end

  def render_method_not_allowed
    render json: { success: false }, status: :method_not_allowed
  end
end
