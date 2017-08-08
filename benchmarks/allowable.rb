# frozen_string_literal: true

require 'benchmark'
require 'bundler/setup'
require 'allowable'
require 'action_controller'

ActionController::Parameters.class_eval do
  include Allowable
end

hash = {}
allow_filters = {}

1_000_000.times do |n|
  hash[n] = n
  allow_filters[n] = n + 1
end

forbid_filters = hash.dup

params = ActionController::Parameters.new(hash)

Benchmark.bmbm do |bm|
  bm.report('Hash#allow') { hash.allow(allow_filters) }
  bm.report('Hash#forbid') { hash.forbid(forbid_filters) }

  bm.report('ActionController::Parameters#allow') do
    params.allow(allow_filters)
  end

  bm.report('ActionController::Parameters#forbid') do
    params.forbid(forbid_filters)
  end
end
