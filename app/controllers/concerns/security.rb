# frozen_string_literal: true

module Security
  extend ActiveSupport::Concern
  def authenticate_admin_or_user
    authenticate(%w[admin user])
  end

  def authenticate_admin
    authenticate(%w[admin])
  end

  def authenticate(roles)
    render_unauthorized unless authorized_role?(roles)
  end

  def authorized_role?(roles)
    roles.any? { |role| resource_present?(role) }
  end

  def show_action?
    action_name == 'show'
  end

  def invalid_fields?
    return true if params['uid']
    (profile_params.keys.map(&:to_sym) - role_params).any?
  end

  def profile_params
    params.permit(valid_params)
  end

  def set_resource
    @resource = requested_resource
  end

  def set_resource_authorization
    @resource = reset_resource
    update_auth_headers
  end

  def reset_resource
    return current_admin if current_admin
    requested_resource
  end

  def requested_resource
    current_role || role_class.find_by_uid(params['uid'])
  end

  def role
    controller_path[/^[a-z]+/]
  end

  def current_role
    instance_eval("current_#{role}")
  end

  def role_class
    role.titleize.constantize
  end
end
