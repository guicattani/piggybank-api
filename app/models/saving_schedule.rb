# frozen_string_literal: true

class SavingSchedule < ApplicationRecord
  validates :period, inclusion: { in: %w[day week month] }
  validates_presence_of :description, :period, :active, :value_in_cents, :period_value
  validates :value_in_cents, numericality: { greater_than: 0 }
  validates :period_value, numericality: { greater_than: 0 }

  after_create :create_next_date

  private

  def create_next_date
    case period
    when 'day'
      self.next_date = Date.today + period_value.days
    when 'week'
      self.next_date = Date.today + period_value.weeks
    when 'month'
      self.next_date = Date.today + period_value.months
    end
  end
end
