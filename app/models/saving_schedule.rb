# frozen_string_literal: true

class SavingSchedule < ApplicationRecord
  validates :active, inclusion: { in: [true, false] }
  validates :description, allow_nil: false
  validates :period, inclusion: { in: ['day, week, month'] }
  # validate :value_in_cents

  # t.boolean :active
  # t.integer :value_in_cents
  # t.string :description
  # t.string :period
  # t.integer :period_value

end
