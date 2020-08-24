require "./setup"

Xclock::MainXrecord.find_each(&:reset_all)
Xclock::SeasonXrecord.find_each(&:reset_all)
tp Xclock::MainXrecord
tp Xclock::SeasonXrecord

# >> |----+---------+----------+----------+--------------+-----------+------------+----------+--------+-------------+------------+--------------------+---------------------+------------------+-------------------+----------+-------------+-----------------+---------------------------+---------------------------+------------------+-----------------|
# >> | id | user_id | judge_id | final_id | battle_count | win_count | lose_count | win_rate | rating | rating_diff | rating_max | straight_win_count | straight_lose_count | straight_win_max | straight_lose_max | skill_id | skill_point | skill_last_diff | created_at                | updated_at                | disconnect_count | disconnected_at |
# >> |----+---------+----------+----------+--------------+-----------+------------+----------+--------+-------------+------------+--------------------+---------------------+------------------+-------------------+----------+-------------+-----------------+---------------------------+---------------------------+------------------+-----------------|
# >> | 40 |      40 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:01 +0900 | 2020-06-27 17:10:25 +0900 |                0 |                 |
# >> | 41 |      41 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:10:25 +0900 |                0 |                 |
# >> | 42 |      42 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |
# >> | 43 |      43 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |
# >> | 44 |      44 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |
# >> | 45 |      45 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |
# >> | 46 |      46 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |
# >> | 47 |      47 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:11 +0900 | 2020-06-27 17:08:11 +0900 |                0 |                 |
# >> | 48 |      48 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:11 +0900 | 2020-06-27 17:08:11 +0900 |                0 |                 |
# >> |----+---------+----------+----------+--------------+-----------+------------+----------+--------+-------------+------------+--------------------+---------------------+------------------+-------------------+----------+-------------+-----------------+---------------------------+---------------------------+------------------+-----------------|
# >> |----+----------+----------+--------------+-----------+------------+----------+--------+-------------+------------+--------------------+---------------------+------------------+-------------------+----------+-------------+-----------------+---------------------------+---------------------------+------------------+-----------------+---------+-----------+--------------+------------|
# >> | id | judge_id | final_id | battle_count | win_count | lose_count | win_rate | rating | rating_diff | rating_max | straight_win_count | straight_lose_count | straight_win_max | straight_lose_max | skill_id | skill_point | skill_last_diff | created_at                | updated_at                | disconnect_count | disconnected_at | user_id | season_id | create_count | generation |
# >> |----+----------+----------+--------------+-----------+------------+----------+--------+-------------+------------+--------------------+---------------------+------------------+-------------------+----------+-------------+-----------------+---------------------------+---------------------------+------------------+-----------------+---------+-----------+--------------+------------|
# >> | 43 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:01 +0900 | 2020-06-27 17:08:01 +0900 |                0 |                 |      40 |        35 |            1 |          1 |
# >> | 44 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:10:25 +0900 |                0 |                 |      41 |        45 |            1 |         11 |
# >> | 45 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |      42 |        45 |            1 |         11 |
# >> | 46 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |      43 |        45 |            1 |         11 |
# >> | 47 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |      44 |        45 |            1 |         11 |
# >> | 48 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |      45 |        45 |            1 |         11 |
# >> | 49 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:10 +0900 | 2020-06-27 17:08:10 +0900 |                0 |                 |      46 |        45 |            1 |         11 |
# >> | 50 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:11 +0900 | 2020-06-27 17:08:11 +0900 |                0 |                 |      47 |        45 |            1 |         11 |
# >> | 51 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:11 +0900 | 2020-06-27 17:08:11 +0900 |                0 |                 |      48 |        45 |            1 |         11 |
# >> | 52 |       20 |        5 |            0 |         0 |          0 |      0.0 | 1500.0 |         0.0 |     1500.0 |                  0 |                   0 |                0 |                 0 |       85 |         0.0 |             0.0 | 2020-06-27 17:08:18 +0900 | 2020-06-27 17:10:25 +0900 |                0 |                 |      40 |        45 |            2 |         11 |
# >> |----+----------+----------+--------------+-----------+------------+----------+--------+-------------+------------+--------------------+---------------------+------------------+-------------------+----------+-------------+-----------------+---------------------------+---------------------------+------------------+-----------------+---------+-----------+--------------+------------|
# >> |-----+-------------+---------+---------+----------+--------+---------------------------+---------------------------|
# >> | id  | question_id | o_count | x_count | ox_total | o_rate | created_at                | updated_at                |
# >> |-----+-------------+---------+---------+----------+--------+---------------------------+---------------------------|
# >> |  83 |          83 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:01 +0900 | 2020-06-27 17:08:01 +0900 |
# >> |  84 |          84 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:02 +0900 | 2020-06-27 17:08:02 +0900 |
# >> |  85 |          85 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:03 +0900 | 2020-06-27 17:08:03 +0900 |
# >> |  86 |          86 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:03 +0900 | 2020-06-27 17:08:03 +0900 |
# >> |  87 |          87 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:04 +0900 | 2020-06-27 17:08:04 +0900 |
# >> |  88 |          88 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:04 +0900 | 2020-06-27 17:08:04 +0900 |
# >> |  89 |          89 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:05 +0900 | 2020-06-27 17:08:05 +0900 |
# >> |  90 |          90 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:06 +0900 | 2020-06-27 17:08:06 +0900 |
# >> |  91 |          91 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:06 +0900 | 2020-06-27 17:08:06 +0900 |
# >> |  92 |          92 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:07 +0900 | 2020-06-27 17:08:07 +0900 |
# >> |  93 |          93 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:07 +0900 | 2020-06-27 17:08:07 +0900 |
# >> |  94 |          94 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:08 +0900 | 2020-06-27 17:08:08 +0900 |
# >> |  95 |          95 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:09 +0900 | 2020-06-27 17:08:09 +0900 |
# >> |  96 |          96 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:11 +0900 | 2020-06-27 17:08:11 +0900 |
# >> |  97 |          97 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:11 +0900 | 2020-06-27 17:08:11 +0900 |
# >> |  98 |          98 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:12 +0900 | 2020-06-27 17:08:12 +0900 |
# >> |  99 |          99 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:13 +0900 | 2020-06-27 17:08:13 +0900 |
# >> | 100 |         100 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:13 +0900 | 2020-06-27 17:08:13 +0900 |
# >> | 101 |         101 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:14 +0900 | 2020-06-27 17:08:14 +0900 |
# >> | 102 |         102 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:15 +0900 | 2020-06-27 17:08:15 +0900 |
# >> | 103 |         103 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:15 +0900 | 2020-06-27 17:08:15 +0900 |
# >> | 104 |         104 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:16 +0900 | 2020-06-27 17:08:16 +0900 |
# >> | 105 |         105 |       0 |       0 |        0 |    0.0 | 2020-06-27 17:08:16 +0900 | 2020-06-27 17:08:16 +0900 |
# >> |-----+-------------+---------+---------+----------+--------+---------------------------+---------------------------|
