# frozen_string_literal: true

require 'pry'

appraise 'rails-3' do
  gem 'railties', '~> 3.2'
  gem 'strong_parameters'
end

appraise 'rails-4' do
  gem 'railties', '~> 4.2'
end

if RUBY_VERSION >= '2.2.2'
  appraise 'rails-5' do
    gem 'railties', '~> 5.1'
  end
end
