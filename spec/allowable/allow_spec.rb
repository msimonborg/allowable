# frozen_string_literal: true

describe Allowable do
  let(:symbol_hash) { { hi: 'hi', hello: 'hello' } }
  let(:string_hash) { { 'hi' => 'hi', 'hello' => 'hello' } }
  let(:nested_hash) { { hi: { hey: 'ho' } } }

  context '#allow' do
    it 'only allows the named keys if they have the specified value' do
      expect(symbol_hash.allow(hello: 'goodbye')).to eq(hi: 'hi')
      expect(string_hash.allow(hello: 'goodbye')).to_not eq('hi' => 'hi')

      expect(symbol_hash.allow('hello' => 'goodbye')).to_not eq(hi: 'hi')
      expect(string_hash.allow('hello' => 'goodbye')).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        symbol_hash.allow(hi: %w[hi hey], hello: %w[bye goodbye])
      ).to eq(hi: 'hi')
      expect(
        string_hash.allow(hi: %w[hi hey], hello: %w[bye goodbye])
      ).to_not eq('hi' => 'hi')

      expect(
        symbol_hash.allow('hi' => %w[hi hey], 'hello' => %w[bye goodbye])
      ).to_not eq(hi: 'hi')
      expect(
        string_hash.allow('hi' => %w[hi hey], 'hello' => %w[bye goodbye])
      ).to eq('hi' => 'hi')
    end

    it 'it can match when the hash value is an array' do
      symbol_hash = { hi: %w[hi hey], hello: 'hello' }
      string_hash = { 'hi' => %w[hi hey], 'hello' => 'hello' }

      expect(symbol_hash.allow(hi: %w[hi hey])).to eq symbol_hash
      expect(string_hash.allow('hi' => %w[hi hey])).to eq string_hash
    end

    it 'does not mutate the original object' do
      expect(symbol_hash.allow(hi: 'hi', hello: 'goodbye')).to eq(hi: 'hi')
      expect(symbol_hash).to eq(hi: 'hi', hello: 'hello')
    end

    it 'validates nested hashes' do
      expect(nested_hash.allow(hi: { hey: 'ho' })).to eq(hi: { hey: 'ho' })
      expect(nested_hash.allow(hi: { hey: 'oh hi' })).to eq({})
      expect(nested_hash.allow(hi: { hello: 'world' })).to eq({})
    end
  end

  context '#allow!' do
    it 'only allows the named keys if they have the specified value' do
      expect(symbol_hash.allow!(hi: 'hi', hello: 'goodbye')).to eq(hi: 'hi')
      expect(string_hash.allow!('hi' => 'hi', 'hello' => 'goodbye')).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        symbol_hash.allow!(hi: %w[hi hey], hello: %w[bye goodbye])
      ).to eq(hi: 'hi')
      expect(
        string_hash.allow!('hi' => %w[hi hey], 'hello' => %w[bye goodbye])
      ).to eq('hi' => 'hi')
    end

    it 'does mutate the original object' do
      expect(symbol_hash.allow!(hi: 'hi', hello: 'goodbye')).to eq(hi: 'hi')
      expect(symbol_hash).to eq(hi: 'hi')
    end

    it 'validates nested hashes' do
      expect(nested_hash.dup.allow!(hi: { hey: 'ho' })).to eq(hi: { hey: 'ho' })
      expect(nested_hash.dup.allow!(hi: { hey: 'oh hi' })).to eq({})
      expect(nested_hash.dup.allow!(hi: { hello: 'world' })).to eq({})
    end
  end
end
