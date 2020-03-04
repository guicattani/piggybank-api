# frozen_string_literal: true

class V1::SavingTransactionSerializer
  include FastJsonapi::ObjectSerializer

  attribute :value_in_cents
end
