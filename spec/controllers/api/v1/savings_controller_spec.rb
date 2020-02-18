# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SavingsController, type: :controller do
  context '#index' do
    context 'logged user' do
      login_user

      let!(:first_saving) do
        FactoryBot.create(:saving, :with_objective_date, user_id: subject.current_user.id)
      end
      let!(:second_saving) do
        FactoryBot.create(:saving, :with_objective_date, user_id: subject.current_user.id)
      end

      it 'returns all savings that the user has' do
        get :index

        expect(parsed_response.count).to eq(2)
      end
    end

    context 'user not logged' do
      it 'returns not found' do
        get :index

        expect(parsed_response).to be_empty
      end
    end
  end
end
