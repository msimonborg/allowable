# frozen_string_literal: true

require 'allowable/allowable'

# Add #allow, #allow!, #forbid, and #forbid! to Hash
class Hash
  include Allowable
end
