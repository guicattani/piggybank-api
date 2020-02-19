# frozen_string_literal: true

FactoryBot.define do
  factory :saving do
    association :user, factory: :user
    color { '#0x123456' }
    currency { 'usd' }
    objective_date { Date.tomorrow }

    trait :with_objective_value do
      objective_value_in_cents { 10_000_00 }
    end

    trait :no_objectives do
      objective_date { nil }
      objective_value_in_cents { nil }
    end
  end
end
