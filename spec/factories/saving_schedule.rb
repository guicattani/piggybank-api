# frozen_string_literal: true

FactoryBot.define do
  factory :saving_schedule do
    association :saving, factory: :saving
    description { 'month paycheck' }
    active { true }
    period { 'month' }
    value_in_cents { 2_000_00 }
    period_value { 1 }
  end
end
