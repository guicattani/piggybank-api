# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }

  before { host! 'api.piggybank.test' }

  describe 'GET /users/:id' do
    before do
      headers = { 'Accept' => 'application/vnd.piggybank.v1' }
      get "/users/#{user_id}", headers: headers
    end

    context 'when user exists' do
      it 'returns user' do
        user_response = JSON.parse(response.body)
        expect(user_response['id']).to eq(user_id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user does not exists' do
      let(:user_id) { 100 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
