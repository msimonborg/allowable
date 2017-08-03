# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'yardstick/rake/verify'
require 'yardstick/rake/measurement'

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec)

Yardstick::Rake::Measurement.new(:yardstick_measure) do |measurement|
  measurement.output = 'measurement/report.txt'
end

Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 50
  verify.require_exact_threshold = false
end

task default: %i[spec rubocop verify_measurements]
