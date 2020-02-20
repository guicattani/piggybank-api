# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1 Users API', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }
  let(:headers) { piggybank_header('v1') }

  before { host! ENV['TEST_HOST'] }

  describe 'PUT /savings/:id' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
    end

    it_behaves_like 'a regular #put action' do
      let!(:endpoint) { { name: "users" } }
      let!(:endpoint_subject) { { name: "user", id: user_id } }
      let!(:attribute) { { name: 'email', content: 'new@new.com', invalid_content: 'invalid'} }
    end
  end
end
