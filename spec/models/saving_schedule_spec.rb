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

  context 'after create' do
    subject { FactoryBot.build(:saving_schedule) }
    context 'next date' do
      it 'calculates a day offset' do
        subject.period = 'day'
        subject.period_value = 1

        subject.save
        expect(subject.next_date).to eq(Date.today + 1.day)
      end
      it 'calculates a day offset' do
        subject.period = 'week'
        subject.period_value = 1

        subject.save
        expect(subject.next_date).to eq(Date.today + 1.week)
      end
      it 'calculates a month offset' do
        subject.period = 'month'
        subject.period_value = 1

        subject.save
        expect(subject.next_date).to eq(Date.today + 1.month)
      end
    end
  end
end
