# -*- coding: utf-8 -*-
# == Schema Information ==
#
# Setting (actb_settings as Actb::Setting)
#
# |------------+----------+------------+-------------+-----------------------+-------|
# | name       | desc     | type       | opts        | refs                  | index |
# |------------+----------+------------+-------------+-----------------------+-------|
# | id         | ID       | integer(8) | NOT NULL PK |                       |       |
# | user_id    | User     | integer(8) | NOT NULL    | => Colosseum::User#id | A     |
# | rule_id    | Rule     | integer(8) | NOT NULL    |                       | B     |
# | created_at | 作成日時 | datetime   | NOT NULL    |                       |       |
# | updated_at | 更新日時 | datetime   | NOT NULL    |                       |       |
# |------------+----------+------------+-------------+-----------------------+-------|
#
#- Remarks ----------------------------------------------------------------------
# Colosseum::User.has_many :actb_room_messages
#--------------------------------------------------------------------------------

module Actb
  class Setting < ApplicationRecord
    belongs_to :user, class_name: "Colosseum::User"
    belongs_to :rule

    before_validation do
      self.rule ||= Rule.fetch(:marathon_rule)
    end
  end
end
