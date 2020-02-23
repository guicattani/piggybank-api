# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SavingSchedule, type: :model do
  context 'validations' do
    it { should validate_inclusion_of(:active).in_array(%w[true false]) }
    it { should validate_inclusion_of(:period).in_array(%w[day week month]) }
    it { should validate_presence_of(:period) }

    let(:saving_schedule) { FactoryBot.build(:saving_schedule)}
    it 'validates that value in cents is always positive' do
      saving_schedule.value_in_cents = -1
      expect(saving_schedule).not to.be_valid
    end

    it 'validates that period is always positive' do
      saving_schedule.period_value = -1
      expect(saving_schedule).not to.be_valid
    end
  end
end
