# -*- coding: utf-8 -*-
# == Schema Information ==
#
# 将棋ウォーズ対戦情報テーブル (wars_records as WarsRecord)
#
# |------------------+--------------------+-------------+-------------+----------------+-------|
# | カラム名         | 意味               | タイプ      | 属性        | 参照           | INDEX |
# |------------------+--------------------+-------------+-------------+----------------+-------|
# | id               | ID                 | integer(8)  | NOT NULL PK |                |       |
# | unique_key       | ユニークなハッシュ | string(255) | NOT NULL    |                |       |
# | battle_key       | Battle key         | string(255) | NOT NULL    |                |       |
# | battled_at       | Battled at         | datetime    | NOT NULL    |                |       |
# | game_type_key    | Game type key      | string(255) | NOT NULL    |                |       |
# | csa_hands        | Csa hands          | text(65535) | NOT NULL    |                |       |
# | reason_key       | Reason key         | string(255) | NOT NULL    |                |       |
# | win_wars_user_id | Win wars user      | integer(8)  |             | => WarsUser#id | A     |
# | turn_max         | 手数               | integer(4)  |             |                |       |
# | kifu_header      | 棋譜ヘッダー       | text(65535) |             |                |       |
# | created_at       | 作成日時           | datetime    | NOT NULL    |                |       |
# | updated_at       | 更新日時           | datetime    | NOT NULL    |                |       |
# |------------------+--------------------+-------------+-------------+----------------+-------|
#
#- 備考 -------------------------------------------------------------------------
# ・【警告:リレーション欠如】WarsUserモデルで has_many :wars_records されていません
#--------------------------------------------------------------------------------

module WarsRecordsHelper
end
