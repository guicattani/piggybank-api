# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }

  before { host! 'api.piggybank.test' }

  describe 'GET /users/:id' do
    before do
      get "/v1/users/#{user_id}", headers: headers
    end

    context 'when user exists' do
      it 'returns user' do
        expect(parsed_attributes['email']).to eq(user.email)
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

  describe 'POST /users' do
    before do
      # params = { "user": user_params }

      post "/v1/users", params: { user: user_params }
    end

    context 'when request params are valid' do
      let(:user_params) { FactoryBot.attributes_for(:user) }

      it 'returns status 201 created' do
        expect(response).to have_http_status(201)
      end
      it 'returns json with created user data' do
        expect(parsed_attributes['email']).to eq(user_params[:email])
      end
    end
  end
end
