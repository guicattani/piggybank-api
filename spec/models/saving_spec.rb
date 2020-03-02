# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Saving, type: :model do
  context 'validations' do
    it { should belong_to(:user) }
    it { should validate_inclusion_of(:currency).in_array(%w[brl usd]) }

    it 'validates that the user has either a objective date or value' do
      expect(FactoryBot.build(:saving, :no_objectives)).not_to be_valid
      expect(FactoryBot.build(:saving, :with_objective_value)).to be_valid
      expect(FactoryBot.build(:saving)).to be_valid
    end
    it 'validates that color accepts either 0x and # with length of 3 or 6' do
      expect(FactoryBot.build(:saving, color: "0x123")).to be_valid
      expect(FactoryBot.build(:saving, color: "#123")).to be_valid
      expect(FactoryBot.build(:saving, color: "0x123456")).to be_valid
      expect(FactoryBot.build(:saving, color: "#123456")).to be_valid

      expect(FactoryBot.build(:saving, color: "123")).not_to be_valid
      expect(FactoryBot.build(:saving, color: "123456")).not_to be_valid
      expect(FactoryBot.build(:saving, color: "#0x123456")).not_to be_valid
      expect(FactoryBot.build(:saving, color: "0x#123456")).not_to be_valid
    end

    it 'validates that the starting value in cents is zero' do
      expect(FactoryBot.create(:saving).value_in_cents).to eq(0)
    end
  end

  context 'scopes' do
    context 'by_user' do
      it 'should return only savings that belong to that user' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        FactoryBot.create(:saving, user_id: user1.id)
        FactoryBot.create(:saving, user_id: user2.id)

        expect(Saving.by_user(user1.id)).not_to include(user2.id)
      end
    end
  end
end
