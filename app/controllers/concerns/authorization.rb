# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern
  def resource_present?(resource)
    instance_eval <<-RUBY, __FILE__, __LINE__ + 1
      "#{resource}_signed_in?"
    RUBY
  end
end
