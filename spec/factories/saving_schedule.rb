# frozen_string_literal: true

FactoryBot.define do
  factory :saving_schedule do
    description { 'month paycheck' }
    active { true }
    period { 'month' }
  end
end