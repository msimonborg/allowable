# frozen_string_literal: true

require 'bundler/setup'
require 'benchmark/ips'
require 'allowable'
require 'action_controller'

ActionController::Parameters.class_eval do
  include Allowable
end

hash = {}
allow_filters = {}

100.times do |n|
  hash[n] = n
  allow_filters[n] = n + 1
end

forbid_filters = hash.dup

params = ActionController::Parameters.new(hash)

Benchmark.ips do |bm|
  bm.report('Hash#allow') { hash.allow(allow_filters) }
  bm.report('Hash#forbid') { hash.forbid(forbid_filters) }

  bm.report('ActionController::Parameters#allow') do
    params.allow(allow_filters)
  end

  bm.report('ActionController::Parameters#forbid') do
    params.forbid(forbid_filters)
  end

  bm.compare!
end
