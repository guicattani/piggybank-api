# frozen_string_literal: true

class Saving < ApplicationRecord
  belongs_to :user
  validates :color, format: { with: /\A(0x|#)(?:[\da-f]{3}){1,2}\z/ }
  validates :currency, inclusion: { in: %w[brl usd] }
  validate :objective_value_or_date
  validate :future_objective_date
  validate :positive_objective_value

  scope :by_user, ->(user_id) { where(user_id: user_id) }

  def objective_value_or_date
    return if !objective_date.nil? || !objective_value_in_cents.nil?

    errors.add(:objective_date, 'Objective date or objective value must be present')
    errors.add(:objective_value_in_cents, 'Objective date or objective value must be present')
  end

  def future_objective_date
    return true if objective_date.nil?

    objective_date >= Date.tomorrow
  end

  def positive_objective_value
    return true if objective_value_in_cents.nil?

    objective_value_in_cents.positive?
  end
end
