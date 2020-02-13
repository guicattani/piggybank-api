# frozen_string_literal: true

class Saving < ApplicationRecord
  belongs_to :users
  validates :color, format: { with: /(0x|#)(?:[\da-f]{3}){1,2}/ }
  validate :future_objective_date
  validate :positive_objective_value

  scope :by_user, ->(user_id){ where(user_id: user_id) }

  def future_objective_date
    objective_date >= Date.tomorrow
  end

  def positive_objective_value
    objective_value.positive?
  end
end
