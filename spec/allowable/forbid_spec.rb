# frozen_string_literal: true

describe Allowable do
  let(:symbol_hash) { { hi: 'hi', hello: 'hello' } }
  let(:string_hash) { { 'hi' => 'hi', 'hello' => 'hello' } }
  let(:nested_hash) { { hi: { hey: 'ho' } } }

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

    it 'it can match when the hash value is an array' do
      symbol_hash = { hi: %w[hi hey], hello: 'hello' }
      string_hash = { 'hi' => %w[hi hey], 'hello' => 'hello' }

      expect(symbol_hash.forbid(hi: %w[hi hey])).to eq(hello: 'hello')
      expect(string_hash.forbid('hi' => %w[hi hey])).to eq('hello' => 'hello')
    end

    it 'does not mutate the original object' do
      expect(symbol_hash.forbid(hi: 'bye', hello: 'hello')).to eq(hi: 'hi')
      expect(symbol_hash).to eq(hi: 'hi', hello: 'hello')
    end

    it 'validates nested hashes' do
      expect(nested_hash.forbid(hi: { hey: 'ho' })).to eq({})
      expect(nested_hash.forbid(hi: { hey: 'oh hi' })).to eq(hi: { hey: 'ho' })
      expect(nested_hash.forbid(hi: { hello: 'world' })).to eq(hi: { hey: 'ho' })
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

    it 'validates nested hashes' do
      expect(nested_hash.dup.forbid!(hi: { hey: 'ho' })).to eq({})
      expect(nested_hash.dup.forbid!(hi: { hey: 'oh hi' })).to eq(hi: { hey: 'ho' })
      expect(nested_hash.dup.forbid!(hi: { hello: 'world' })).to eq(hi: { hey: 'ho' })
    end
  end
end
