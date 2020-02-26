# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SavingSchedule, type: :model do
  context 'validations' do
    subject { FactoryBot.build(:saving_schedule) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:value_in_cents) }
    it { should validate_presence_of(:period_value) }
    it { should validate_presence_of(:period) }
    it { should validate_presence_of(:active) }
    it { should validate_inclusion_of(:period).in_array(%w[day week month]) }

    it 'validates that value in cents is always positive' do
      subject.value_in_cents = -1
      expect(subject).not_to be_valid
    end

    it 'validates that period is always positive' do
      subject.period_value = -1
      expect(subject).not_to be_valid
    end
  end
end
