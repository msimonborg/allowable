# frozen_string_literal: true

describe Allowable::Forbid do
  let(:symbol_hash) { { hi: 'hi', hello: 'hello' } }
  let(:string_hash) { { 'hi' => 'hi', 'hello' => 'hello' } }

  context 'when included' do
    it 'adds #forbid and #forbid! instance methods' do
      class ForbidTestObject; end

      expect(ForbidTestObject.new).not_to respond_to :forbid
      expect(ForbidTestObject.new).not_to respond_to :forbid!

      ForbidTestObject.class_eval { include Allowable::Forbid }

      expect(ForbidTestObject.new).to respond_to :forbid
      expect(ForbidTestObject.new).to respond_to :forbid!
    end
  end

  context '#forbid' do
    it 'only forbids the named keys if they have the specified value' do
      expect(symbol_hash.forbid(hi: 'bye', hello: 'hello')).to eq(hi: 'hi')
      expect(string_hash.forbid(hi: 'bye', hello: 'hello')).to_not eq('hi' => 'hi')

      expect(symbol_hash.forbid('hi' => 'bye', 'hello' => 'hello')).to_not eq(hi: 'hi')
      expect(string_hash.forbid('hi' => 'bye', 'hello' => 'hello')).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        symbol_hash.forbid(hi: %w[bye byebye], hello: %w[hello hey])
      ).to eq(hi: 'hi')
      expect(
        string_hash.forbid(hi: %w[bye byebye], hello: %w[hello hey])
      ).to_not eq('hi' => 'hi')

      expect(
        symbol_hash.forbid('hi' => %w[bye byebye], 'hello' => %w[hello hey])
      ).to_not eq(hi: 'hi')
      expect(
        string_hash.forbid('hi' => %w[bye byebye], 'hello' => %w[hello hey])
      ).to eq('hi' => 'hi')
    end

    it 'does not mutate the original object' do
      expect(symbol_hash.forbid(hi: 'bye', hello: 'hello')).to eq(hi: 'hi')
      expect(symbol_hash).to eq(hi: 'hi', hello: 'hello')
    end
  end

  context '#forbid!' do
    it 'only forbids the named keys if they have the specified value' do
      expect(symbol_hash.forbid!(hi: 'bye', hello: 'hello')).to eq(hi: 'hi')
      expect(string_hash.forbid!('hi' => 'bye', 'hello' => 'hello')).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        symbol_hash.forbid!(hi: %w[bye byebye], hello: %w[hello hey])
      ).to eq(hi: 'hi')
      expect(
        string_hash.forbid!('hi' => %w[bye byebye], 'hello' => %w[hello hey])
      ).to eq('hi' => 'hi')
    end

    it 'does mutate the original object' do
      expect(symbol_hash.forbid!(hi: 'bye', hello: 'hello')).to eq(hi: 'hi')
      expect(symbol_hash).to eq(hi: 'hi')
    end
  end
end
