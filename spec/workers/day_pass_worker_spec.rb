# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DayPassWorker do
  context 'when there is a Saving Schedule which next_day is today' do
    let!(:saving_schedule) { FactoryBot.create(:saving_schedule) }

    before do
      saving_schedule.next_date = Date.today
      saving_schedule.save
    end

    it 'updates the saving value' do
      expect(saving_schedule.saving.value_in_cents).to eq(0)
      subject.perform
      expect(saving_schedule.reload.saving.value_in_cents).to eq(saving_schedule.value_in_cents)
    end
    it 'updates saving_schedule next date' do
      subject.perform

      expect(saving_schedule.reload.next_date).not_to eq(Date.today)
    end
  end
end
