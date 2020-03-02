# frozen_string_literal: true

class SavingSchedule < ApplicationRecord
  belongs_to :saving
  validates :period, inclusion: { in: %w[day week month] }
  validates :value_in_cents, numericality: { greater_than: 0 }
  validates :period_value, numericality: { greater_than: 0 }
  validates_presence_of :description, :period, :active, :value_in_cents, :period_value

  before_create :calculate_next_date, :validate_presence_of_next_date

  scope :active, -> { where(active: true) }
  scope :next_date_is_today, -> { where(next_date: Date.today) }

  def calculate_next_date
    case period
    when 'day'
      self.next_date = Date.today + period_value.days
    when 'week'
      self.next_date = Date.today + period_value.weeks
    when 'month'
      self.next_date = Date.today + period_value.months
    end
  end

  private

  def validate_presence_of_next_date
    return unless next_date.nil?

    errors.add(:next_date, 'next_date has to be present')
  end
end
