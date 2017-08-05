# frozen_string_literal: true

describe Allowable do
  it 'is included in Hash when required' do
    expect(Hash.include?(Allowable)).to be true
  end

  it 'is included in ActiveSupport::HashWithIndifferentAccess' do
    expect(ActiveSupport::HashWithIndifferentAccess.include?(Allowable)).to be true
  end
end
