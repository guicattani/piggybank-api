# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SavingTransaction, type: :model do
  context 'validations' do
    it { should belong_to(:saving) }
    it { should validate_presence_of(:value_in_cents) }
  end
end
