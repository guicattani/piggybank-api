# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1 Savings API', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }
  let(:headers) { piggybank_header('v1') }

  before { host! ENV['TEST_HOST'] }

end
