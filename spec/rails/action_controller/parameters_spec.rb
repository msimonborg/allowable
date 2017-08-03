# frozen_string_literal: true

ActiveSupport.run_load_hooks(:action_controller, ActionController::Base)

describe ActionController::Parameters do
  it 'includes Allowable' do
    expect(ActionController::Parameters.include?(Allowable)).to be true
  end

  let(:params) do
    ActionController::Parameters.new(hi: 'hi', hello: 'hello').permit(:hi, :hello)
  end

  context '#allow' do
    it 'only allows the named keys if they have the specified value' do
      expect(params.allow(hi: 'hi', hello: 'goodbye').to_h).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        params.allow(hi: %w[hi hey], hello: %w[bye goodbye]).to_h
      ).to eq('hi' => 'hi')
    end

    it 'does not mutate the original object' do
      expect(params.allow(hi: 'hi', hello: 'goodbye').to_h).to eq('hi' => 'hi')
      expect(params.to_h).to eq('hi' => 'hi', 'hello' => 'hello')
    end
  end

  context '#allow!' do
    it 'only allows the named keys if they have the specified value' do
      expect(params.allow!(hi: 'hi', hello: 'goodbye').to_h).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        params.allow!(hi: %w[hi hey], hello: %w[bye goodbye]).to_h
      ).to eq('hi' => 'hi')
    end

    it 'does mutate the original object' do
      expect(params.allow!(hi: 'hi', hello: 'goodbye').to_h).to eq('hi' => 'hi')
      expect(params.to_h).to eq('hi' => 'hi')
    end
  end

  context '#forbid' do
    it 'only forbids the named keys if they have the specified value' do
      expect(params.forbid(hi: 'bye', hello: 'hello').to_h).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        params.forbid(hi: %w[bye byebye], hello: %w[hello hey]).to_h
      ).to eq('hi' => 'hi')
    end

    it 'does not mutate the original object' do
      expect(params.forbid(hi: 'bye', hello: 'hello').to_h).to eq('hi' => 'hi')
      expect(params.to_h).to eq('hi' => 'hi', 'hello' => 'hello')
    end
  end

  context '#forbid!' do
    it 'only forbids the named keys if they have the specified value' do
      expect(params.forbid!(hi: 'bye', hello: 'hello').to_h).to eq('hi' => 'hi')
    end

    it 'works with arrays of values' do
      expect(
        params.forbid!(hi: %w[bye byebye], hello: %w[hello hey]).to_h
      ).to eq('hi' => 'hi')
    end

    it 'does mutate the original object' do
      expect(params.forbid!(hi: 'bye', hello: 'hello').to_h).to eq('hi' => 'hi')
      expect(params.to_h).to eq('hi' => 'hi')
    end
  end
end
