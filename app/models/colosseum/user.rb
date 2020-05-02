require "colosseum"

module Colosseum
  class User < ApplicationRecord
    concerning :BasicMethods do
      included do
        before_validation on: :create do
          self.key ||= SecureRandom.hex
          self.password ||= Devise.friendly_token(32)
          self.email ||= "#{key}@localhost"
        end
      end

      class_methods do
        def setup(options = {})
          super
          tp create!(name: "alice")
          tp create!(name: "bob")
        end
      end
    end

    concerning :DeviseMethods do
      included do
        devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
      end
    end
  end
end
