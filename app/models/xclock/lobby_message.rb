# -*- coding: utf-8 -*-
# == Schema Information ==
#
# Lobby message (xclock_lobby_messages as Xclock::LobbyMessage)
#
# |------------+----------+-------------+-------------+--------------+-------|
# | name       | desc     | type        | opts        | refs         | index |
# |------------+----------+-------------+-------------+--------------+-------|
# | id         | ID       | integer(8)  | NOT NULL PK |              |       |
# | user_id    | User     | integer(8)  | NOT NULL    | => ::User#id | A     |
# | body       | 内容     | string(512) | NOT NULL    |              |       |
# | created_at | 作成日時 | datetime    | NOT NULL    |              |       |
# | updated_at | 更新日時 | datetime    | NOT NULL    |              |       |
# |------------+----------+-------------+-------------+--------------+-------|
#
#- Remarks ----------------------------------------------------------------------
# User.has_one :profile
#--------------------------------------------------------------------------------

module Xclock
  class LobbyMessage < ApplicationRecord
    include MessageShared

    after_create_commit do
      Xclock::LobbyMessageBroadcastJob.perform_later(self)
    end
  end
end
