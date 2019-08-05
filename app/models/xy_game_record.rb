# -*- coding: utf-8 -*-
# == Schema Information ==
#
# Xy game record (xy_game_records as XyGameRecord)
#
# |-------------------+----------------+-------------+-------------+------+-------|
# | name              | desc           | type        | opts        | refs | index |
# |-------------------+----------------+-------------+-------------+------+-------|
# | id                | ID             | integer(8)  | NOT NULL PK |      |       |
# | name              | Name           | string(255) |             |      |       |
# | summary           | Summary        | string(255) |             |      |       |
# | rule_key       | Ranking key    | string(255) |             |      |       |
# | colosseum_user_id | Colosseum user | integer(8)  |             |      | A     |
# | o_count_max       | O count max    | integer(4)  |             |      |       |
# | o_count           | O count        | integer(4)  |             |      |       |
# | x_count           | X count        | integer(4)  |             |      |       |
# | spent_msec       | Timer count    | integer(4)  |             |      |       |
# | created_at        | 作成日時       | datetime    | NOT NULL    |      |       |
# | updated_at        | 更新日時       | datetime    | NOT NULL    |      |       |
# |-------------------+----------------+-------------+-------------+------+-------|
#
#- Remarks ----------------------------------------------------------------------
# [Warning: Need to add relation] XyGameRecord モデルに belongs_to :colosseum_user を追加してください
#--------------------------------------------------------------------------------

class XyGameRecord < ApplicationRecord
  before_validation on: :create do
    self.summary = summary.to_s.squish
  end

  def computed_rank
    XyGameRanking[rule_key].computed_rank(-spent_msec)
  end
end
