# frozen_string_literal: true

# Add #allow, #allow!, #forbid, and #forbid! to Hash
class Hash
  include Allowable
end
