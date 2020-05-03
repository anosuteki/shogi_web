# -*- coding: utf-8 -*-
# == Schema Information ==
#
# ユーザー (colosseum_users as Colosseum::User)
#
# |--------------------+--------------------+-------------+--------------------+------+-------|
# | name               | desc               | type        | opts               | refs | index |
# |--------------------+--------------------+-------------+--------------------+------+-------|
# | id                 | ID                 | integer(8)  | NOT NULL PK        |      |       |
# | key                | ユニークなハッシュ | string(255) |                    |      |       |
# | name               | 名前               | string(255) |                    |      |       |
# | email              | メールアドレス     | string(255) |                    |      |       |
# | encrypted_password | Encrypted password | string(255) | DEFAULT() NOT NULL |      |       |
# | created_at         | 作成日時           | datetime    | NOT NULL           |      |       |
# | updated_at         | 更新日時           | datetime    | NOT NULL           |      |       |
# |--------------------+--------------------+-------------+--------------------+------+-------|

require "colosseum"

module Colosseum
  class User < ApplicationRecord
    has_many :acns1_messages, :class_name => "Acns1::Message", :dependent => :destroy

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
