#!/usr/bin/env ruby
require File.expand_path('../../config/environment', __FILE__)

module Swars
  user1 = User.create!
  user2 = User.create!

  battle = Battle.new
  battle.csa_seq = [["+5756FU", 0],["-5354FU", 0],["+5958OU", 0],["-5152OU", 0],["+5857OU", 0],["-5253OU", 0],["+5746OU", 0],["-5364OU", 0],["+4645OU", 0],["-6465OU", 0],["+4544OU", 0],["-6566OU", 0],["+4453OU", 0],["-6657OU", 0]]
  battle.memberships.build(user: user1, judge_key: :win,  location_key: :black)
  battle.memberships.build(user: user2, judge_key: :lose, location_key: :white)
  battle.save!                  # => true

  battle.reload
  puts battle.to_cached_kifu(:kif)
  battle.note_tag_list     # => ["入玉", "相入玉", "居飛車", "相居飛車"]
  battle.memberships[0].reload.note_tag_list # => ["入玉", "相入玉", "居飛車", "相居飛車"]
  battle.memberships[1].reload.note_tag_list # => ["入玉", "相入玉", "居飛車", "相居飛車"]

  user1.tactic_summary_for(:note) # => {"<a class=\"no-decoration\" href=\"/tactics/%E5%85%A5%E7%8E%89\">入玉</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6b11d2dd66ef167d699d2c75c91aec02+muser%3A6b11d2dd66ef167d699d2c75c91aec02+ms_tag%3A%E5%85%A5%E7%8E%89\">1</a>", "<a class=\"no-decoration\" href=\"/tactics/%E7%9B%B8%E5%85%A5%E7%8E%89\">相入玉</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6b11d2dd66ef167d699d2c75c91aec02+muser%3A6b11d2dd66ef167d699d2c75c91aec02+ms_tag%3A%E7%9B%B8%E5%85%A5%E7%8E%89\">1</a>", "<a class=\"no-decoration\" href=\"/tactics/%E5%B1%85%E9%A3%9B%E8%BB%8A\">居飛車</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6b11d2dd66ef167d699d2c75c91aec02+muser%3A6b11d2dd66ef167d699d2c75c91aec02+ms_tag%3A%E5%B1%85%E9%A3%9B%E8%BB%8A\">1</a>", "<a class=\"no-decoration\" href=\"/tactics/%E7%9B%B8%E5%B1%85%E9%A3%9B%E8%BB%8A\">相居飛車</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6b11d2dd66ef167d699d2c75c91aec02+muser%3A6b11d2dd66ef167d699d2c75c91aec02+ms_tag%3A%E7%9B%B8%E5%B1%85%E9%A3%9B%E8%BB%8A\">1</a>"}
  user2.tactic_summary_for(:note) # => {"<a class=\"no-decoration\" href=\"/tactics/%E5%85%A5%E7%8E%89\">入玉</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6ffbeba0e766f3f594c3bd96e31ad095+muser%3A6ffbeba0e766f3f594c3bd96e31ad095+ms_tag%3A%E5%85%A5%E7%8E%89\">1</a>", "<a class=\"no-decoration\" href=\"/tactics/%E7%9B%B8%E5%85%A5%E7%8E%89\">相入玉</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6ffbeba0e766f3f594c3bd96e31ad095+muser%3A6ffbeba0e766f3f594c3bd96e31ad095+ms_tag%3A%E7%9B%B8%E5%85%A5%E7%8E%89\">1</a>", "<a class=\"no-decoration\" href=\"/tactics/%E5%B1%85%E9%A3%9B%E8%BB%8A\">居飛車</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6ffbeba0e766f3f594c3bd96e31ad095+muser%3A6ffbeba0e766f3f594c3bd96e31ad095+ms_tag%3A%E5%B1%85%E9%A3%9B%E8%BB%8A\">1</a>", "<a class=\"no-decoration\" href=\"/tactics/%E7%9B%B8%E5%B1%85%E9%A3%9B%E8%BB%8A\">相居飛車</a>"=>"<a href=\"/w?import_skip=true&amp;per=500&amp;query=6ffbeba0e766f3f594c3bd96e31ad095+muser%3A6ffbeba0e766f3f594c3bd96e31ad095+ms_tag%3A%E7%9B%B8%E5%B1%85%E9%A3%9B%E8%BB%8A\">1</a>"}

  tp Battle.last
end
# >> 先手：6b11d2dd66ef167d699d2c75c91aec02 30級
# >> 後手：6ffbeba0e766f3f594c3bd96e31ad095 30級
# >> 開始日時：2020/01/06 10:56:18
# >> 棋戦：将棋ウォーズ(10分切れ負け)
# >> 場所：https://shogiwars.heroz.jp/games/b36cb5b2d89d989b66f05bfda948f2bb
# >> 持ち時間：10分
# >> 先手の備考：入玉, 相入玉, 居飛車, 相居飛車
# >> 後手の備考：入玉, 相入玉, 居飛車, 相居飛車
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 ５六歩(57)   (10:00/00:10:00)
# >>    2 ５四歩(53)   (10:00/00:10:00)
# >>    3 ５八玉(59)   (00:00/00:10:00)
# >>    4 ５二玉(51)   (00:00/00:10:00)
# >>    5 ５七玉(58)   (00:00/00:10:00)
# >>    6 ５三玉(52)   (00:00/00:10:00)
# >>    7 ４六玉(57)   (00:00/00:10:00)
# >>    8 ６四玉(53)   (00:00/00:10:00)
# >>    9 ４五玉(46)   (00:00/00:10:00)
# >>   10 ６五玉(64)   (00:00/00:10:00)
# >>   11 ４四玉(45)   (00:00/00:10:00)
# >>   12 ６六玉(65)   (00:00/00:10:00)
# >>   13 ５三玉(44)   (00:00/00:10:00)
# >> *▲備考：入玉
# >>   14 ５七玉(66)   (00:00/00:10:00)
# >> *△備考：入玉
# >>   15 投了
# >> まで14手で後手の勝ち
# >> |--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# >> |                 id | 34                                                                                                                                                                                                                                                                                                  |
# >> |                key | b36cb5b2d89d989b66f05bfda948f2bb                                                                                                                                                                                                                                                                    |
# >> |         battled_at | 2020-01-06 10:56:18 +0900                                                                                                                                                                                                                                                                           |
# >> |           rule_key | ten_min                                                                                                                                                                                                                                                                                             |
# >> |            csa_seq | [["+5756FU", 0], ["-5354FU", 0], ["+5958OU", 0], ["-5152OU", 0], ["+5857OU", 0], ["-5253OU", 0], ["+5746OU", 0], ["-5364OU", 0], ["+4645OU", 0], ["-6465OU", 0], ["+4544OU", 0], ["-6566OU", 0], ["+4453OU", 0], ["-6657OU", 0]]                                                                    |
# >> |          final_key | TORYO                                                                                                                                                                                                                                                                                               |
# >> |        win_user_id | 58                                                                                                                                                                                                                                                                                                  |
# >> |           turn_max | 14                                                                                                                                                                                                                                                                                                  |
# >> |          meta_info | {:header=>{"先手"=>"6b11d2dd66ef167d699d2c75c91aec02 30級", "後手"=>"6ffbeba0e766f3f594c3bd96e31ad095 30級", "開始日時"=>"2020/01/06 10:56:18", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "場所"=>"https://shogiwars.heroz.jp/games/b36cb5b2d89d989b66f05bfda948f2bb", "持ち時間"=>"00:10+00", "先手の... |
# >> |    last_accessd_at | 2020-01-06 10:56:18 +0900                                                                                                                                                                                                                                                                           |
# >> |  access_logs_count | 0                                                                                                                                                                                                                                                                                                   |
# >> |         created_at | 2020-01-06 10:56:19 +0900                                                                                                                                                                                                                                                                           |
# >> |         updated_at | 2020-01-06 10:56:19 +0900                                                                                                                                                                                                                                                                           |
# >> |         preset_key | 平手                                                                                                                                                                                                                                                                                                |
# >> |         start_turn |                                                                                                                                                                                                                                                                                                     |
# >> |      critical_turn |                                                                                                                                                                                                                                                                                                     |
# >> |         saturn_key | public                                                                                                                                                                                                                                                                                              |
# >> |          sfen_body | position startpos moves 5g5f 5c5d 5i5h 5a5b 5h5g 5b5c 5g4f 5c6d 4f4e 6d6e 4e4d 6e6f 4d5c 6f5g                                                                                                                                                                                                       |
# >> |         image_turn |                                                                                                                                                                                                                                                                                                     |
# >> |   defense_tag_list |                                                                                                                                                                                                                                                                                                     |
# >> |    attack_tag_list |                                                                                                                                                                                                                                                                                                     |
# >> | technique_tag_list |                                                                                                                                                                                                                                                                                                     |
# >> |      note_tag_list |                                                                                                                                                                                                                                                                                                     |
# >> |     other_tag_list |                                                                                                                                                                                                                                                                                                     |
# >> |    secret_tag_list |                                                                                                                                                                                                                                                                                                     |
# >> | kifu_body_for_test |                                                                                                                                                                                                                                                                                                     |
# >> |--------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
