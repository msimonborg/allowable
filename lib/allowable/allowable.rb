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
  def self.filter_match?(obj, key, val)
    Array(val).include?(obj[key]) || val == obj[key]
  end

  def allow(filters = {})
    dup.allow!(filters)
  end

  def allow!(filters = {})
    filters.each do |key, val|
      delete(key) unless Allowable.filter_match?(self, key, val)
    end
    self
  end

  def forbid(filters = {})
    dup.forbid!(filters)
  end

  def forbid!(filters = {})
    filters.each do |key, val|
      delete(key) if Allowable.filter_match?(self, key, val)
    end
    self
  end
end
