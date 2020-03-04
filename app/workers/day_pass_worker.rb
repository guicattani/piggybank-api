# frozen_string_literal: true

class DayPassWorker
  include Sidekiq::Worker

  def perform
    SavingSchedule.active.next_date_is_today.each do |saving_schedule|
      saving_schedule.saving.value_in_cents += saving_schedule.value_in_cents
      saving_schedule.saving.save
      saving_schedule.calculate_next_date
      saving_schedule.save

      log_saving_transaction(saving_schedule)
    end
  end

  private

  def log_saving_transaction(saving_schedule)
    SavingTransaction.create(saving_id: saving_schedule.saving.id,
                             value_in_cents: saving_schedule.value_in_cents,
                             scheduled: true)
  end
end
