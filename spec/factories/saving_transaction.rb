# frozen_string_literal: true

FactoryBot.define do
  factory :saving_transaction do
    association :saving, factory: :saving
    value_in_cents { 2_000_00 }
  end
end
