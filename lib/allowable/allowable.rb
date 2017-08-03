# frozen_string_literal: true

require 'allowable/allow'
require 'allowable/forbid'

# Filter hashes by setting  allowed or forbidden values for specific keys.
#
#     hash = { one: 'one', two: 'two' }
#
#     hash.forbid(one: 'one') # => { two: 'two' }
#
#     hash.allow(one: 'two') # => { two: 'two' }
#
#     hash.allow(one: ['one', 'two']) # => { one: 'one', two: 'two' }
#
#     hash.forbid(one: ['one', 'two']) # => { two: 'two' }
#
#     hash.allow!(one: 'two') # => { two: 'two' }
#
#     hash.forbid!(two: 'two') # => {}
#
#     hash # => {}
module Allowable
  include Forbid
  include Allow
end
