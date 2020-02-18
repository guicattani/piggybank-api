# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern
  def resource_present?(resource)
    instance_eval "#{resource}_signed_in?"
  end
end
