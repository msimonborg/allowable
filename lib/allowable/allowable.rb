# frozen_string_literal: true

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
  def allow(filters = {})
    dup.allow!(filters)
  end

  def allow!(filters = {})
    filters.each do |key, val|
      delete(key) unless Array(val).include?(self[key]) || val == self[key]
    end
    self
  end

  def forbid(filters = {})
    dup.forbid!(filters)
  end

  def forbid!(filters = {})
    filters.each do |key, val|
      delete(key) if Array(val).include?(self[key]) || val == self[key]
    end
    self
  end
end
