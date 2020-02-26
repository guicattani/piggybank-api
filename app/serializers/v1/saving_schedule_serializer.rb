# frozen_string_literal: true

class V1::SavingScheduleSerializer
  include FastJsonapi::ObjectSerializer

  attribute :description, :active, :period, :value_in_cents, :period_value, :next_date
end
