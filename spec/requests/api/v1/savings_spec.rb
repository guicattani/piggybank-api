# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1 Savings API', type: :request do
  let!(:saving) { FactoryBot.create(:saving) }
  let(:saving_id) { saving.id }
  let(:headers) { piggybank_header('v1') }

  before { host! ENV['TEST_HOST'] }

  describe 'GET /savings/:id' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      saving.update(user_id: user.id)
    end

    it_behaves_like 'a regular #show action' do
      let!(:endpoint) { { name: "savings" } }
      let!(:endpoint_subject) { { id: saving_id } }
      let!(:attribute) { { name: 'color', content: saving.color } }
    end
  end

  describe 'POST /savings' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      saving.update(user_id: user.id)
    end

    it_behaves_like 'a regular #create action' do
      let!(:endpoint) { { name: "savings" } }
      let!(:endpoint_subject) { { name: "saving", id: saving_id } }
      let!(:attribute) { { name: 'color', content: saving.color, invalid_content: '0x1' } }
    end
  end

  describe 'PUT /savings/:id' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      saving.update(user_id: user.id)
    end

    it_behaves_like 'a regular #put action' do
      let!(:endpoint) { { name: "savings" } }
      let!(:endpoint_subject) { { name: "saving", id: saving_id } }
      let!(:attribute) { { name: 'color', content: '0x654321', invalid_content: '0x1' } }
    end
  end

  describe 'DELETE /savings/:id' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      saving.update(user_id: user.id)
    end

    it_behaves_like 'a regular #delete action' do
      let!(:endpoint) { { name: "savings" } }
      let!(:endpoint_subject) { { name: "saving", id: saving_id } }
      let!(:class_name) { "Saving" }
    end
  end
end
