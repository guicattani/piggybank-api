# frozen_string_literal: true

RSpec.shared_examples 'a valid subject' do
  it 'returns subject.valid? as true' do
    expect(subject.valid?).to be_truthy
  end
end