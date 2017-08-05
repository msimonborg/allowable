# frozen_string_literal: true

require 'rails/railtie'

module Allowable
  # Railtie initializer that adds Allowable methods to controller params
  class Railtie < ::Rails::Railtie
    if Rails::VERSION::MAJOR >= 5
      initializer :allowable do
        ActiveSupport.on_load :action_controller do
          ActionController::Parameters.send :include, ::Allowable
        end
      end
    end
  end
end
