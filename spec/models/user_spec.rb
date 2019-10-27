# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context 'when created' do
    it 'responds to valid methods' do
      expect(subject).to respond_to(:email)
      expect(subject).to respond_to(:password)
      expect(subject).to respond_to(:password_confirmation)
      expect(subject).to be_valid
    end
  end
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value('abcde@email.com').for(:email) }
  it { is_expected.to validate_confirmation_of(:password) }
end
