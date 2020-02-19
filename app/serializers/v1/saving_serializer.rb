# frozen_string_literal: true

class V1::SavingSerializer
  include FastJsonapi::ObjectSerializer

  attribute :value_in_cents, :objective_date, :objective_value_in_cents, :color
            :currency
end
