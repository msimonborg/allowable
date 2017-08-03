# frozen_string_literal: true

module Allowable
  # Adds the #allow and #allow! methods
  module Allow
    def allow(filters = {})
      dup.allow!(filters)
    end

    def allow!(filters = {})
      filters.each do |key, val|
        delete(key) unless Array(val).include?(self[key])
      end
      self
    end
  end
end
