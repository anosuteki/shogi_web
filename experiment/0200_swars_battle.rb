#!/usr/bin/env ruby
require File.expand_path('../../config/environment', __FILE__)

Swars::Battle.user_import(user_key: "devuser1")

# Swars::Battle.destroy_all
# Swars::Battle.destroy_all
# 
# Swars::Battle.import(:remake)

tp Swars::Battle.all.last(10).collect(&:attributes)

tp Swars::Battle
# >> |----+-----------------------------------------+---------------------------+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+-------------+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------+-------------------+---------------------------+---------------------------+------------------+-----------------+----------------+-----------------|
# >> | id | key                                     | battled_at                | rule_key | csa_seq                                                                                                                                                                                                                                                             | final_key | win_user_id | turn_max | meta_info                                                                                                                                                                                                                                                                                                                                 | last_accessd_at           | access_logs_count | created_at                | updated_at                | defense_tag_list | attack_tag_list | other_tag_list | secret_tag_list |
# >> |----+-----------------------------------------+---------------------------+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+-------------+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------+-------------------+---------------------------+---------------------------+------------------+-----------------+----------------+-----------------|
# >> |  1 | msetsuo-Ito_Asuka-20190111_230933       | 2019-01-11 23:09:33 +0900 | ten_min  | [["+2726FU", 598], ["-3334FU", 600], ["+2625FU", 596], ["-2233KA", 599], ["+1716FU", 595], ["-1314FU", 597], ["+3948GI", 593], ["-8384FU", 512], ["+4958KI", 586], ["-8485FU", 510], ["+6978KI", 584], ["-4132KI", 504], ["+4746FU", 577], ["-8586FU", 500], ["+... | TIMEOUT   |           2 |       84 | {:header=>{"先手"=>"msetsuo 2級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 23:09:33", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "先手の囲い"=>"いちご囲い"}, :detail_names=>[[], []], :simple_names=>[[["msetsuo", "2級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{"先手の...                           | 2019-01-12 14:05:33 +0900 |                 0 | 2019-01-12 14:05:33 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  2 | Takechan831-Ito_Asuka-20190111_223848   | 2019-01-11 22:38:48 +0900 | ten_min  | [["-7162GI", 599], ["+7776FU", 599], ["-5354FU", 598], ["+2726FU", 598], ["-4132KI", 597], ["+2625FU", 596], ["-6253GI", 595], ["+7968GI", 590], ["-4344FU", 590], ["+6877GI", 585], ["-5162OU", 588], ["+2524FU", 584], ["-2324FU", 587], ["+2824HI", 583], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"Takechan831 29級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 22:38:48", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["Takechan", "83129級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                     | 2019-01-12 14:05:34 +0900 |                 0 | 2019-01-12 14:05:34 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  3 | kibou36-Ito_Asuka-20190111_222649       | 2019-01-11 22:26:49 +0900 | ten_min  | [["-7162GI", 599], ["+7776FU", 599], ["-5354FU", 598], ["+3948GI", 598], ["-6253GI", 597], ["+4746FU", 596], ["-4132KI", 591], ["+4645FU", 595], ["-5162OU", 589], ["+4847GI", 594], ["-6172KI", 586], ["+4746GI", 593], ["-6364FU", 578], ["+3736FU", 592], ["-... | TORYO     |           4 |        0 | {:header=>{"先手"=>"kibou36 三段", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 22:26:49", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["kibou36", "三段"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                             | 2019-01-12 14:05:34 +0900 |                 0 | 2019-01-12 14:05:34 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  4 | Ito_Asuka-kz0619-20190111_190218        | 2019-01-11 19:02:18 +0900 | ten_min  | [["+7776FU", 595], ["-3334FU", 598], ["+2726FU", 590], ["-8384FU", 594], ["+2625FU", 577], ["-8485FU", 592], ["+6978KI", 576], ["-4132KI", 590], ["+2524FU", 575], ["-2324FU", 589], ["+2824HI", 574], ["-8586FU", 587], ["+8786FU", 573], ["-8286HI", 586], ["+... | CHECKMATE |           2 |      115 | {:header=>{"先手"=>"Ito_Asuka 十段", "後手"=>"kz0619 初段", "開始日時"=>"2019/01/11 19:02:18", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "先手の戦型"=>"ひねり飛車"}, :detail_names=>[[], []], :simple_names=>[[["Ito_Asuka", "十段"]], [["kz0619", "初段"]]], :skill_set_hash=>{"先手の戦型...                       | 2019-01-12 14:05:34 +0900 |                 0 | 2019-01-12 14:05:34 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  5 | SOAREMAN-Ito_Asuka-20190111_181540      | 2019-01-11 18:15:40 +0900 | ten_min  | [["+7776FU", 598], ["-3334FU", 599], ["+6766FU", 597], ["-8384FU", 598], ["+2868HI", 595], ["-7162GI", 597], ["+8877KA", 592], ["-5142OU", 595], ["+3938GI", 591], ["-4232OU", 593], ["+6958KI", 585], ["-5354FU", 592], ["+1716FU", 583], ["-1314FU", 591], ["+... | TORYO     |           2 |       56 | {:header=>{"先手"=>"SOAREMAN 初段", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 18:15:40", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "後手の囲い"=>"舟囲い", "先手の戦型"=>"四間飛車, 腰掛け銀"}, :detail_names=>[[], []], :simple_names=>[[["SOAREMAN", "初段"]], [["Ito_Asuka", "十段"]]],...                 | 2019-01-12 14:05:35 +0900 |                 0 | 2019-01-12 14:05:35 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  6 | yuga_jus-Ito_Asuka-20190111_171547      | 2019-01-11 17:15:47 +0900 | ten_min  | [["-7162GI", 599], ["+7776FU", 598], ["-5354FU", 598], ["+2726FU", 597], ["-4132KI", 597], ["+2625FU", 594], ["-6253GI", 596], ["+2524FU", 593], ["-2324FU", 594], ["+2824HI", 592], ["-0023FU", 593], ["+2426HI", 588], ["-5162OU", 592], ["+3938GI", 585], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"yuga_jus 二段", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 17:15:47", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["yuga_jus", "二段"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                           | 2019-01-12 14:05:35 +0900 |                 0 | 2019-01-12 14:05:35 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  7 | kekkun-Ito_Asuka-20190111_162548        | 2019-01-11 16:25:48 +0900 | ten_min  | [["+7968GI", 598], ["-3334FU", 593], ["+5756FU", 596], ["-3142GI", 562], ["+6857GI", 594], ["-5354FU", 551], ["+2726FU", 588], ["-4253GI", 538], ["+2625FU", 586], ["-2233KA", 537], ["+8879KA", 582], ["-5344GI", 527], ["+5746GI", 570], ["-8252HI", 520], ["+... | TORYO     |           2 |       88 | {:header=>{"先手"=>"kekkun 1級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 16:25:48", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "後手の囲い"=>"片美濃囲い", "先手の戦型"=>"嬉野流"}, :detail_names=>[[], []], :simple_names=>[[["kekkun", "1級"]], [["Ito_Asuka", "十段"]]], :skill_s...                      | 2019-01-12 14:05:36 +0900 |                 0 | 2019-01-12 14:05:36 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  8 | Ito_Asuka-akkunn_xx-20190111_130425     | 2019-01-11 13:04:25 +0900 | ten_min  | [["+7776FU", 598], ["-3334FU", 598], ["+2858HI", 585], ["-5142OU", 595], ["+5756FU", 583], ["-4232OU", 592], ["+5948OU", 551], ["-5354FU", 588], ["+4838OU", 547], ["-7162GI", 585], ["+3828OU", 532], ["-6253GI", 580], ["+3938GI", 517], ["-1314FU", 577], ["+... | TORYO     |           9 |       66 | {:header=>{"先手"=>"Ito_Asuka 十段", "後手"=>"akkunn_xx 四段", "開始日時"=>"2019/01/11 13:04:25", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "先手の囲い"=>"片美濃囲い", "後手の囲い"=>"左美濃", "先手の戦型"=>"ゴキゲン中飛車, 角交換振り飛車, 角換わり"}, :detail_names=>[[], []], :simple_names=>[[["Ito_Asuka",... | 2019-01-12 14:05:36 +0900 |                 0 | 2019-01-12 14:05:36 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  9 | takayanyanta-Ito_Asuka-20190111_124228  | 2019-01-11 12:42:28 +0900 | ten_min  | [["-7162GI", 599], ["+2858HI", 596], ["-5354FU", 596], ["+5756FU", 594], ["-6253GI", 593], ["+7968GI", 593], ["-3142GI", 591], ["+6857GI", 592], ["-4344FU", 591], ["+5948OU", 588], ["-4243GI", 589], ["+5766GI", 587], ["-4132KI", 586], ["+4838OU", 586], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"takayanyanta 11級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 12:42:28", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["takayanyanta", "11級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                   | 2019-01-12 14:05:36 +0900 |                 0 | 2019-01-12 14:05:36 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> | 10 | MinoriChihara-Ito_Asuka-20190111_084942 | 2019-01-11 08:49:42 +0900 | ten_min  | [["-7162GI", 599], ["+2726FU", 597], ["-4132KI", 598], ["+6978KI", 590], ["-5354FU", 596], ["+3948GI", 588], ["-6253GI", 595], ["+9796FU", 582], ["-9394FU", 594], ["+7776FU", 568], ["-4344FU", 592], ["+7968GI", 563], ["-5162OU", 589], ["+6877GI", 552], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"MinoriChihara 2級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 08:49:42", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["MinoriChihara", "2級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                   | 2019-01-12 14:31:14 +0900 |                 1 | 2019-01-12 14:05:37 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |----+-----------------------------------------+---------------------------+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+-------------+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------+-------------------+---------------------------+---------------------------+------------------+-----------------+----------------+-----------------|
# >> |----+-----------------------------------------+---------------------------+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+-------------+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------+-------------------+---------------------------+---------------------------+------------------+-----------------+----------------+-----------------|
# >> | id | key                                     | battled_at                | rule_key | csa_seq                                                                                                                                                                                                                                                             | final_key | win_user_id | turn_max | meta_info                                                                                                                                                                                                                                                                                                                                 | last_accessd_at           | access_logs_count | created_at                | updated_at                | defense_tag_list | attack_tag_list | other_tag_list | secret_tag_list |
# >> |----+-----------------------------------------+---------------------------+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+-------------+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------+-------------------+---------------------------+---------------------------+------------------+-----------------+----------------+-----------------|
# >> |  1 | msetsuo-Ito_Asuka-20190111_230933       | 2019-01-11 23:09:33 +0900 | ten_min  | [["+2726FU", 598], ["-3334FU", 600], ["+2625FU", 596], ["-2233KA", 599], ["+1716FU", 595], ["-1314FU", 597], ["+3948GI", 593], ["-8384FU", 512], ["+4958KI", 586], ["-8485FU", 510], ["+6978KI", 584], ["-4132KI", 504], ["+4746FU", 577], ["-8586FU", 500], ["+... | TIMEOUT   |           2 |       84 | {:header=>{"先手"=>"msetsuo 2級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 23:09:33", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "先手の囲い"=>"いちご囲い"}, :detail_names=>[[], []], :simple_names=>[[["msetsuo", "2級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{"先手の...                           | 2019-01-12 14:05:33 +0900 |                 0 | 2019-01-12 14:05:33 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  2 | Takechan831-Ito_Asuka-20190111_223848   | 2019-01-11 22:38:48 +0900 | ten_min  | [["-7162GI", 599], ["+7776FU", 599], ["-5354FU", 598], ["+2726FU", 598], ["-4132KI", 597], ["+2625FU", 596], ["-6253GI", 595], ["+7968GI", 590], ["-4344FU", 590], ["+6877GI", 585], ["-5162OU", 588], ["+2524FU", 584], ["-2324FU", 587], ["+2824HI", 583], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"Takechan831 29級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 22:38:48", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["Takechan", "83129級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                     | 2019-01-12 14:05:34 +0900 |                 0 | 2019-01-12 14:05:34 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  3 | kibou36-Ito_Asuka-20190111_222649       | 2019-01-11 22:26:49 +0900 | ten_min  | [["-7162GI", 599], ["+7776FU", 599], ["-5354FU", 598], ["+3948GI", 598], ["-6253GI", 597], ["+4746FU", 596], ["-4132KI", 591], ["+4645FU", 595], ["-5162OU", 589], ["+4847GI", 594], ["-6172KI", 586], ["+4746GI", 593], ["-6364FU", 578], ["+3736FU", 592], ["-... | TORYO     |           4 |        0 | {:header=>{"先手"=>"kibou36 三段", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 22:26:49", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["kibou36", "三段"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                             | 2019-01-12 14:05:34 +0900 |                 0 | 2019-01-12 14:05:34 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  4 | Ito_Asuka-kz0619-20190111_190218        | 2019-01-11 19:02:18 +0900 | ten_min  | [["+7776FU", 595], ["-3334FU", 598], ["+2726FU", 590], ["-8384FU", 594], ["+2625FU", 577], ["-8485FU", 592], ["+6978KI", 576], ["-4132KI", 590], ["+2524FU", 575], ["-2324FU", 589], ["+2824HI", 574], ["-8586FU", 587], ["+8786FU", 573], ["-8286HI", 586], ["+... | CHECKMATE |           2 |      115 | {:header=>{"先手"=>"Ito_Asuka 十段", "後手"=>"kz0619 初段", "開始日時"=>"2019/01/11 19:02:18", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "先手の戦型"=>"ひねり飛車"}, :detail_names=>[[], []], :simple_names=>[[["Ito_Asuka", "十段"]], [["kz0619", "初段"]]], :skill_set_hash=>{"先手の戦型...                       | 2019-01-12 14:05:34 +0900 |                 0 | 2019-01-12 14:05:34 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  5 | SOAREMAN-Ito_Asuka-20190111_181540      | 2019-01-11 18:15:40 +0900 | ten_min  | [["+7776FU", 598], ["-3334FU", 599], ["+6766FU", 597], ["-8384FU", 598], ["+2868HI", 595], ["-7162GI", 597], ["+8877KA", 592], ["-5142OU", 595], ["+3938GI", 591], ["-4232OU", 593], ["+6958KI", 585], ["-5354FU", 592], ["+1716FU", 583], ["-1314FU", 591], ["+... | TORYO     |           2 |       56 | {:header=>{"先手"=>"SOAREMAN 初段", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 18:15:40", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "後手の囲い"=>"舟囲い", "先手の戦型"=>"四間飛車, 腰掛け銀"}, :detail_names=>[[], []], :simple_names=>[[["SOAREMAN", "初段"]], [["Ito_Asuka", "十段"]]],...                 | 2019-01-12 14:05:35 +0900 |                 0 | 2019-01-12 14:05:35 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  6 | yuga_jus-Ito_Asuka-20190111_171547      | 2019-01-11 17:15:47 +0900 | ten_min  | [["-7162GI", 599], ["+7776FU", 598], ["-5354FU", 598], ["+2726FU", 597], ["-4132KI", 597], ["+2625FU", 594], ["-6253GI", 596], ["+2524FU", 593], ["-2324FU", 594], ["+2824HI", 592], ["-0023FU", 593], ["+2426HI", 588], ["-5162OU", 592], ["+3938GI", 585], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"yuga_jus 二段", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 17:15:47", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["yuga_jus", "二段"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                           | 2019-01-12 14:05:35 +0900 |                 0 | 2019-01-12 14:05:35 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  7 | kekkun-Ito_Asuka-20190111_162548        | 2019-01-11 16:25:48 +0900 | ten_min  | [["+7968GI", 598], ["-3334FU", 593], ["+5756FU", 596], ["-3142GI", 562], ["+6857GI", 594], ["-5354FU", 551], ["+2726FU", 588], ["-4253GI", 538], ["+2625FU", 586], ["-2233KA", 537], ["+8879KA", 582], ["-5344GI", 527], ["+5746GI", 570], ["-8252HI", 520], ["+... | TORYO     |           2 |       88 | {:header=>{"先手"=>"kekkun 1級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 16:25:48", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "後手の囲い"=>"片美濃囲い", "先手の戦型"=>"嬉野流"}, :detail_names=>[[], []], :simple_names=>[[["kekkun", "1級"]], [["Ito_Asuka", "十段"]]], :skill_s...                      | 2019-01-12 14:05:36 +0900 |                 0 | 2019-01-12 14:05:36 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  8 | Ito_Asuka-akkunn_xx-20190111_130425     | 2019-01-11 13:04:25 +0900 | ten_min  | [["+7776FU", 598], ["-3334FU", 598], ["+2858HI", 585], ["-5142OU", 595], ["+5756FU", 583], ["-4232OU", 592], ["+5948OU", 551], ["-5354FU", 588], ["+4838OU", 547], ["-7162GI", 585], ["+3828OU", 532], ["-6253GI", 580], ["+3938GI", 517], ["-1314FU", 577], ["+... | TORYO     |           9 |       66 | {:header=>{"先手"=>"Ito_Asuka 十段", "後手"=>"akkunn_xx 四段", "開始日時"=>"2019/01/11 13:04:25", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00", "先手の囲い"=>"片美濃囲い", "後手の囲い"=>"左美濃", "先手の戦型"=>"ゴキゲン中飛車, 角交換振り飛車, 角換わり"}, :detail_names=>[[], []], :simple_names=>[[["Ito_Asuka",... | 2019-01-12 14:05:36 +0900 |                 0 | 2019-01-12 14:05:36 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |  9 | takayanyanta-Ito_Asuka-20190111_124228  | 2019-01-11 12:42:28 +0900 | ten_min  | [["-7162GI", 599], ["+2858HI", 596], ["-5354FU", 596], ["+5756FU", 594], ["-6253GI", 593], ["+7968GI", 593], ["-3142GI", 591], ["+6857GI", 592], ["-4344FU", 591], ["+5948OU", 588], ["-4243GI", 589], ["+5766GI", 587], ["-4132KI", 586], ["+4838OU", 586], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"takayanyanta 11級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 12:42:28", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["takayanyanta", "11級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                   | 2019-01-12 14:05:36 +0900 |                 0 | 2019-01-12 14:05:36 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> | 10 | MinoriChihara-Ito_Asuka-20190111_084942 | 2019-01-11 08:49:42 +0900 | ten_min  | [["-7162GI", 599], ["+2726FU", 597], ["-4132KI", 598], ["+6978KI", 590], ["-5354FU", 596], ["+3948GI", 588], ["-6253GI", 595], ["+9796FU", 582], ["-9394FU", 594], ["+7776FU", 568], ["-4344FU", 592], ["+7968GI", 563], ["-5162OU", 589], ["+6877GI", 552], ["-... | TORYO     |           2 |        0 | {:header=>{"先手"=>"MinoriChihara 2級", "後手"=>"Ito_Asuka 十段", "開始日時"=>"2019/01/11 08:49:42", "棋戦"=>"将棋ウォーズ(10分切れ負け)", "持ち時間"=>"00:10+00"}, :detail_names=>[[], []], :simple_names=>[[["MinoriChihara", "2級"]], [["Ito_Asuka", "十段"]]], :skill_set_hash=>{}}                                                   | 2019-01-12 14:31:14 +0900 |                 1 | 2019-01-12 14:05:37 +0900 | 2019-01-12 15:19:24 +0900 |                  |                 |                |                 |
# >> |----+-----------------------------------------+---------------------------+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+-------------+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------+-------------------+---------------------------+---------------------------+------------------+-----------------+----------------+-----------------|
