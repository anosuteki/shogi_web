# -*- coding: utf-8 -*-
# == Schema Information ==
#
# History (actb_histories as Actb::History)
#
# |---------------+------------+------------+-------------+------------------------------+-------|
# | name          | desc       | type       | opts        | refs                         | index |
# |---------------+------------+------------+-------------+------------------------------+-------|
# | id            | ID         | integer(8) | NOT NULL PK |                              |       |
# | user_id       | User       | integer(8) | NOT NULL    | => ::User#id                 | A     |
# | question_id   | Question   | integer(8) | NOT NULL    |                              | B     |
# | created_at    | 作成日時   | datetime   | NOT NULL    |                              |       |
# | updated_at    | 更新日時   | datetime   | NOT NULL    |                              |       |
# | room_id       | Room       | integer(8) | NOT NULL    |                              | C     |
# | battle_id     | Battle     | integer(8) | NOT NULL    |                              | D     |
# | membership_id | Membership | integer(8) | NOT NULL    | => Actb::BattleMembership#id | E     |
# | ox_mark_id    | Ox mark    | integer(8) | NOT NULL    |                              | F     |
# | rating        | Rating     | float(24)  | NOT NULL    |                              |       |
# |---------------+------------+------------+-------------+------------------------------+-------|
#
#- Remarks ----------------------------------------------------------------------
# Actb::BattleMembership.has_many :histories, foreign_key: :membership_id
# User.has_many :actb_room_messages
#--------------------------------------------------------------------------------

module Actb
  class History < ApplicationRecord
    include ClipMark::ShareWithHistoryMethods # belongs_to user and question

    cattr_accessor(:notice_trigger_counts) do
      case
      when Rails.env.development? || Rails.env.test? || Rails.env.staging?
        [1, 5, 10]
      else
        [10, 25, 50, 100, 200, 300, 400, 500]
      end
    end

    scope :today_only, -> { where(created_at: Time.current.midnight...Time.current.midnight.tomorrow) }
    scope :ox_mark_eq, -> ox_mark_key { where(ox_mark: OxMark.fetch(ox_mark_key)) }

    belongs_to :ox_mark

    # この3つは使ってない？
    # → user, question, membership で find するため membership は必要
    # room, battle はなくてもいい
    belongs_to :room
    belongs_to :battle
    belongs_to :membership, class_name: "Actb::BattleMembership"

    before_validation do
      if membership
        self.battle ||= membership.battle
      end

      if battle
        self.room ||= battle.room
      end

      # 調査用
      if user
        self.rating ||= user.rating
      end

      self.ox_mark ||= OxMark.fetch(:mistake)
    end

    after_save_commit do
      if saved_change_to_attribute?(:ox_mark_id) && ox_mark.key == "correct"
        count = user.today_total_o_ucount
        notice_trigger_counts.each do |e|
          if count == e
            User.bot.lobby_speak("#{user.linked_name}さんが本日#{count}問解きました")
            break
          end
        end
      end
    end
  end
end
