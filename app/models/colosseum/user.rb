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
    concerning :BasicMethods do
      included do
        before_validation on: :create do
          self.key ||= SecureRandom.hex

          if Rails.env.production? || Rails.env.staging?
            self.password ||= Devise.friendly_token(32)
          else
            self.password ||= "password"
          end

          self.email ||= "#{key}@localhost"
        end

        after_create do
          if Rails.env.production? || Rails.env.staging?
            UserMailer.user_created(self).deliver_now
          end

          SlackAgent.message_send(key: "ユーザー登録", body: attributes.slice("id", "name"))
        end
      end

      class_methods do
        def setup(options = {})
          super
          create!(name: "alice")
          create!(name: "bob")
        end
      end

      def show_path
        Rails.application.routes.url_helpers.url_for([self, only_path: true])
      end
    end

    concerning :DeviseMethods do
      included do
        devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
      end
    end
  end
end
