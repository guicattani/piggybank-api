# frozen_string_literal: true

class V1::UserSerializer
  include FastJsonapi::ObjectSerializer

  attribute :email
end
