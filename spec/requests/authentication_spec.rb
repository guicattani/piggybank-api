# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:url) { '/login' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end
  let(:invalid_params) do
    {
      user: {
        email: "doesntexist@email.com",
        password: "password"
      }
    }
  end

  before { host! 'api.piggybank.test' }

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      token_from_request = response.headers['Authorization'].split(' ').last
      decoded_token = JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)

      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when login params are missing' do
    before { post url }

    it 'returns unathorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when login params are invalid' do
    before do
      post url, params: invalid_params
    end

    it 'returns unathorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

RSpec.describe 'DELETE /logout', type: :request do
  let(:url) { '/logout' }

  before { host! 'api.piggybank.test' }

  it 'returns 204, no content' do

    delete url
    expect(response).to have_http_status(:no_content)
  end
end
