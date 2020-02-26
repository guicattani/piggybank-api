# frozen_string_literal: true

class SavingSchedule < ApplicationRecord
  validates :period, inclusion: { in: %w[day week month] }
  validates_presence_of :description, :period, :active, :value_in_cents, :period_value
  validates :value_in_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :period_value, numericality: { greater_than_or_equal_to: 0 }
end
