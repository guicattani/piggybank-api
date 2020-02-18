# frozen_string_literal: true

module ResponseHelper
  def render_created(resource)
    render_resource(resource, :created)
  end

  def render_ok(resource)
    render_resource(resource, :ok)
  end

  def render_resource(resource, status)
    if resource.is_a?(ActiveRecord::Relation)
      render json: resource, status: status
    else
      render json: resource,
             status: status,
             serializer: serializer_for(resource)
    end
  end

  def render_unprocessable_entity(message = t('errors.messages.unprocessable'))
    render json: { errors: [message] }, status: :unprocessable_entity
  end

  def render_gateway_timeout(message)
    render json: { errors: [t("errors.messages.#{message}")] },
           status: :gateway_timeout
  end

  def render_not_found(message = 'errors.messages.not_found')
    render json: { errors: [t(message)] },
           status: :not_found
  end

  def render_bad_request
    render json: { errors: [t('errors.messages.bad_request')] },
           status: :bad_request
  end

  def render_forbidden(message = 'errors.messages.forbidden')
    render json: { errors: [t(message)] },
           status: :forbidden
  end

  def render_unauthorized(message = 'devise.failure.unauthenticated')
    render json: { errors: [t(message)] },
           status: :unauthorized
  end

  def render_payment_required(message = 'devise.failure.payment_required')
    render json: { errors: [t(message)] },
           status: :payment_required
  end

  def render_accepted
    render json: { success: [t('devise.invitations.updated')] },
           status: :accepted
  end

  def render_precondition_failed(message)
    render json: { success: [message] },
           status: :precondition_failed
  end

  def render_no_content
    render json: { success: true }, status: :no_content
  end

  def render_method_not_allowed
    render json: { success: false }, status: :method_not_allowed
  end

  private

  def serializer_for(entity)
    if %w[
      node item medium
    ].include? entity.class.to_s.downcase
      return "Entity#{entity.class}Serializer"
             .constantize
    end
    nil
  end
end
