# frozen_string_literal: true

module Allowable
  # Adds the #forbid and #forbid! methods
  module Forbid
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
end
