# frozen_string_literal: true

class DayPassWorker
  include Sidekiq::Worker

  def perform
    SavingSchedule.active.next_date_is_today.each do |saving_schedule|
      saving_schedule.saving.value_in_cents += saving_schedule.value_in_cents
      saving_schedule.saving.save
      saving_schedule.calculate_next_date
      saving_schedule.save
    end
  end
end
