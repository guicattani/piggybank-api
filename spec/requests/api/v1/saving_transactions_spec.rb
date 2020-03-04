# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1 Saving Transactions API', type: :request do
  let!(:saving) { FactoryBot.create(:saving) }
  let(:headers) { piggybank_header('v1') }

  before(:each) do
    host! ENV['TEST_HOST']

    user = FactoryBot.create(:user)
    sign_in user
    saving.update(user_id: user.id)
  end

  describe 'GET /saving_transactions/' do
    context 'when subject exists' do
      let!(:saving_transaction) { FactoryBot.create(:saving_transaction, saving_id: saving.id) }
      before do
        get "/saving_transactions", params: { saving_id: saving.id }, headers: headers
      end

      it "returns list of subjects" do
        expect(parsed_response).not_to be_empty
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when subject does not exists" do
      it 'returns status 404' do
        get "/saving_transactions", params: { saving_id: saving.id }, headers: headers

        expect(parsed_response["data"]).to be_nil
      end
    end
  end

  describe 'POST /saving_transactions/' do
    before do
      post "/saving_transactions",
           params: endpoint_subject_params.to_json, headers: headers
    end

    context 'when request params are valid' do
      let(:endpoint_subject_params) do
        { saving_id: saving.id, value_in_cents: 2_000_00 }
      end
      it 'returns status 201 created' do
        expect(response).to have_http_status(201)
      end
      it 'the corresponding saving increases in value' do
        expect(saving.reload.value_in_cents).to eq(2_000_00)
      end
    end

    context 'when request params are not valid' do
      let(:endpoint_subject_params) do
        { saving_id: saving.id }
      end

      it 'response has status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json with errors' do
        expect(parsed_response).to have_key('errors')
      end
    end
  end

  describe 'DELETE /savings/:id' do
    let!(:saving_transaction) { FactoryBot.create(:saving_transaction, saving_id: saving.id) }

    before do
      delete "/saving_transactions/#{saving_transaction.id}",
             params: { saving_id: saving.id }.to_json, headers: headers
    end

    
    context 'when request params are valid' do
      it 'returns status 204' do
        expect(response).to have_http_status(204)
      end

      it 'user is deleted for good' do
        expect(SavingTransaction.find_by(id: saving_transaction.id)).to be_nil
      end
    end
  end
end
