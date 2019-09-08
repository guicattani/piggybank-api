# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context 'when name is blank' do
    before { subject.name = ' ' }
    it { expect(subject).not_to be_valid }
  end
  context 'when created' do
    it 'responds to valid methods' do
      expect(subject).to respond_to(:email)
      expect(subject).to respond_to(:password)
      expect(subject).to respond_to(:password_confirmation)
      expect(subject).to be_valid
    end
  end
  it { is_expected.to validate_presence_of(:name) }

end
