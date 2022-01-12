# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'allowable/version'

Gem::Specification.new do |spec|
  spec.name                  = 'allowable'
  spec.version               = Allowable::VERSION
  spec.authors               = ['M. Simon Borg']
  spec.email                 = ['msimonborg@gmail.com']
  spec.required_ruby_version = '>= 2.4'

  spec.summary       = 'Filter hash keys based on allowed and forbidden values.'
  spec.description   = 'Filter hash keys based on allowed and forbidden values.'
  spec.homepage      = 'https://github.com/msimonborg/allowable'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z lib LICENSE.txt README.md CHANGELOG.md`.split("\0")

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.14'
  spec.add_development_dependency 'rake', '>= 12.3.3'
end
