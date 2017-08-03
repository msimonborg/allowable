# frozen_string_literal: true

describe Allowable do
  it 'includes Allowable::Allow and Allowable::Forbid when included' do
    class AllowableTestObject; end

    expect(AllowableTestObject.include?(Allowable::Allow)).not_to be true
    expect(AllowableTestObject.include?(Allowable::Forbid)).not_to be true

    AllowableTestObject.class_eval { include Allowable }

    expect(AllowableTestObject.include?(Allowable::Allow)).to be true
    expect(AllowableTestObject.include?(Allowable::Forbid)).to be true
  end

  it 'is included in Hash when required' do
    expect(Hash.include?(Allowable)).to be true
  end
end
