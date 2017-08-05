# frozen_string_literal: true

require 'pry'

if RUBY_VERSION < '2.4.0'
  appraise 'rails-3' do
    gem 'railties', '~> 3.2'
    gem 'strong_parameters'
  end
end

if RUBY_VERSION >= '1.9.3'
  appraise 'rails-4' do
    gem 'railties', '~> 4.2'
  end
end

if RUBY_VERSION >= '2.2.2'
  appraise 'rails-5' do
    gem 'railties', '~> 5.1'
  end
end
