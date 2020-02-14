# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Saving, type: :model do
  context 'validations' do
    it { should belong_to(:user) }

    let!(:saving) { FactoryBot.build(:saving, :no_objectives) }
    it 'validates that the user has either a objective date or value' do
      expect(FactoryBot.build(:saving, :no_objectives)).not_to be_valid
      expect(FactoryBot.build(:saving, :with_objective_value)).to be_valid
      expect(FactoryBot.build(:saving, :with_objective_date)).to be_valid
    end
  end
end
