# frozen_string_literal: true

class SavingSchedule < ApplicationRecord
  validates :active, inclusion: { in: [true, false] }
  validates :period, inclusion: { in: ['day, week, month'] }
  validates_presence_of :description
  validate :positive_value_in_cents
  validate :positive_period_value

  private

  def positive_value_in_cents
    value_in_cents > 0
  end

  def positive_period_value
    period_value > 0
  end

end
