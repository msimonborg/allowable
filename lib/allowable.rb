# frozen_string_literal: true

require 'allowable/version'
require 'allowable/allowable'
require 'allowable/core_ext/hash'

begin
  require 'active_support/core_ext/hash/indifferent_access'
  ActiveSupport::HashWithIndifferentAccess.include Allowable
rescue LoadError
  # do nothing
end

require 'allowable/railtie' if defined? Rails
