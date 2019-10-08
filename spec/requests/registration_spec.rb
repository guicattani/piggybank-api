# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:params) { FactoryBot.attributes_for(:user) }

  before { host! 'api.piggybank.test' }

  context 'when user is unauthenticated' do
    before { post url, params: { user: params } }

    it 'returns 200' do
      expect(response.status).to eq 200
    end
  end

  context 'when user already exists' do
    before do
      FactoryBot.create(:user)
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end
  end
end
