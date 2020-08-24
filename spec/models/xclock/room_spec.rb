# -*- coding: utf-8 -*-
# == Schema Information ==
#
# Room (xclock_rooms as Xclock::Room)
#
# |---------------+---------------+------------+---------------------+------+-------|
# | name          | desc          | type       | opts                | refs | index |
# |---------------+---------------+------------+---------------------+------+-------|
# | id            | ID            | integer(8) | NOT NULL PK         |      |       |
# | begin_at      | Begin at      | datetime   | NOT NULL            |      | A     |
# | end_at        | End at        | datetime   |                     |      | B     |
# | rule_id       | Rule          | integer(8) | NOT NULL            |      | C     |
# | created_at    | 作成日時      | datetime   | NOT NULL            |      |       |
# | updated_at    | 更新日時      | datetime   | NOT NULL            |      |       |
# | battles_count | Battles count | integer(4) | DEFAULT(0) NOT NULL |      | D     |
# | practice      | Practice      | boolean    |                     |      |       |
# | bot_user_id   | Bot user      | integer(8) |                     |      | E     |
# |---------------+---------------+------------+---------------------+------+-------|

require 'rails_helper'

module Xclock
  RSpec.describe Room, type: :model do
    include XclockSupportMethods

    it "練習モードで作成した部屋から作ったバトルは練習モードを引き継いでいる" do
      room = Room.create_with_members!([User.bot, user1], practice: true, bot_user: User.bot)

      assert { room.bot_user == User.bot }
      assert { User.bot.xclock_bot_rooms === [room] }

      battle = room.battle_create_with_members!
      assert { battle.kind_of?(Xclock::Battle) }
    end
  end
end
# >> |-------------------+-----------|
# >> | chromedriver 残骸 | ["85222"] |
# >> |              削除 | 消えない  |
# >> |-------------------+-----------|
# >> Run options: exclude {:slow_spec=>true}
# >> .
# >> 
# >> Finished in 1 second (files took 7.44 seconds to load)
# >> 1 example, 0 failures
# >> 
