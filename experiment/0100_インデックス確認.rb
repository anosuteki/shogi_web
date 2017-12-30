#!/usr/bin/env ruby
require File.expand_path('../../config/environment', __FILE__)

ActiveRecord::Base.connection.tables.sort.each do |e|
  puts
  puts e
  tp ActiveRecord::Base.connection.indexes(e).collect(&:to_h)
end
# >> 
# >> ar_internal_metadata
# >> 
# >> converted_infos
# >> |-----------------+--------------------------------------------------------------+--------+----------------------------------------+---------+--------+-------+------+-------+---------|
# >> | table           | name                                                         | unique | columns                                | lengths | orders | where | type | using | comment |
# >> |-----------------+--------------------------------------------------------------+--------+----------------------------------------+---------+--------+-------+------+-------+---------|
# >> | converted_infos | index_converted_infos_on_convertable_type_and_convertable_id | false  | ["convertable_type", "convertable_id"] | {}      |        |       |      | btree |         |
# >> | converted_infos | index_converted_infos_on_text_format                         | false  | ["text_format"]                        | {}      |        |       |      | btree |         |
# >> |-----------------+--------------------------------------------------------------+--------+----------------------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> free_swars_battle_records
# >> |---------------------------+-----------------------------------------------+--------+----------------+---------+--------+-------+------+-------+---------|
# >> | table                     | name                                          | unique | columns        | lengths | orders | where | type | using | comment |
# >> |---------------------------+-----------------------------------------------+--------+----------------+---------+--------+-------+------+-------+---------|
# >> | free_swars_battle_records | index_free_swars_battle_records_on_unique_key | false  | ["unique_key"] | {}      |        |       |      | btree |         |
# >> |---------------------------+-----------------------------------------------+--------+----------------+---------+--------+-------+------+-------+---------|
# >> 
# >> general_battle_records
# >> |------------------------+---------------------------------------------------+--------+-----------------------+---------+--------+-------+------+-------+---------|
# >> | table                  | name                                              | unique | columns               | lengths | orders | where | type | using | comment |
# >> |------------------------+---------------------------------------------------+--------+-----------------------+---------+--------+-------+------+-------+---------|
# >> | general_battle_records | index_general_battle_records_on_battle_key        | true   | ["battle_key"]        | {}      |        |       |      | btree |         |
# >> | general_battle_records | index_general_battle_records_on_general_battle_state_key | false  | ["general_battle_state_key"] | {}      |        |       |      | btree |         |
# >> |------------------------+---------------------------------------------------+--------+-----------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> general_battle_ships
# >> |----------------------+--------------------------------------------------------+--------+----------------------------------------------+---------+--------+-------+------+-------+---------|
# >> | table                | name                                                   | unique | columns                                      | lengths | orders | where | type | using | comment |
# >> |----------------------+--------------------------------------------------------+--------+----------------------------------------------+---------+--------+-------+------+-------+---------|
# >> | general_battle_ships | general_battle_ships_gbri_lk                           | true   | ["general_battle_record_id", "location_key"] | {}      |        |       |      | btree |         |
# >> | general_battle_ships | index_general_battle_ships_on_general_battle_record_id | false  | ["general_battle_record_id"]                 | {}      |        |       |      | btree |         |
# >> | general_battle_ships | index_general_battle_ships_on_judge_key                | false  | ["judge_key"]                                | {}      |        |       |      | btree |         |
# >> | general_battle_ships | index_general_battle_ships_on_location_key             | false  | ["location_key"]                             | {}      |        |       |      | btree |         |
# >> | general_battle_ships | index_general_battle_ships_on_position                 | false  | ["position"]                                 | {}      |        |       |      | btree |         |
# >> |----------------------+--------------------------------------------------------+--------+----------------------------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> general_battle_users
# >> |----------------------+------------------------------------+--------+----------+---------+--------+-------+------+-------+---------|
# >> | table                | name                               | unique | columns  | lengths | orders | where | type | using | comment |
# >> |----------------------+------------------------------------+--------+----------+---------+--------+-------+------+-------+---------|
# >> | general_battle_users | index_general_battle_users_on_name | true   | ["name"] | {}      |        |       |      | btree |         |
# >> |----------------------+------------------------------------+--------+----------+---------+--------+-------+------+-------+---------|
# >> 
# >> schema_migrations
# >> 
# >> swars_battle_grades
# >> |---------------------+-----------------------------------------+--------+----------------+---------+--------+-------+------+-------+---------|
# >> | table               | name                                    | unique | columns        | lengths | orders | where | type | using | comment |
# >> |---------------------+-----------------------------------------+--------+----------------+---------+--------+-------+------+-------+---------|
# >> | swars_battle_grades | index_swars_battle_grades_on_unique_key | true   | ["unique_key"] | {}      |        |       |      | btree |         |
# >> | swars_battle_grades | index_swars_battle_grades_on_priority   | false  | ["priority"]   | {}      |        |       |      | btree |         |
# >> |---------------------+-----------------------------------------+--------+----------------+---------+--------+-------+------+-------+---------|
# >> 
# >> swars_battle_records
# >> |----------------------+--------------------------------------------------------+--------+------------------------------+---------+--------+-------+------+-------+---------|
# >> | table                | name                                                   | unique | columns                      | lengths | orders | where | type | using | comment |
# >> |----------------------+--------------------------------------------------------+--------+------------------------------+---------+--------+-------+------+-------+---------|
# >> | swars_battle_records | index_swars_battle_records_on_battle_key               | true   | ["battle_key"]               | {}      |        |       |      | btree |         |
# >> | swars_battle_records | index_swars_battle_records_on_battle_rule_key          | false  | ["battle_rule_key"]          | {}      |        |       |      | btree |         |
# >> | swars_battle_records | index_swars_battle_records_on_battle_state_key         | false  | ["battle_state_key"]         | {}      |        |       |      | btree |         |
# >> | swars_battle_records | index_swars_battle_records_on_win_swars_battle_user_id | false  | ["win_swars_battle_user_id"] | {}      |        |       |      | btree |         |
# >> |----------------------+--------------------------------------------------------+--------+------------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> swars_battle_ships
# >> |--------------------+----------------------------------------------------+--------+----------------------------------------------------+---------+--------+-------+------+-------+---------|
# >> | table              | name                                               | unique | columns                                            | lengths | orders | where | type | using | comment |
# >> |--------------------+----------------------------------------------------+--------+----------------------------------------------------+---------+--------+-------+------+-------+---------|
# >> | swars_battle_ships | swars_battle_ships_sbri_lk                         | true   | ["swars_battle_record_id", "location_key"]         | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | swars_battle_ships_sbri_sbui                       | true   | ["swars_battle_record_id", "swars_battle_user_id"] | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | index_swars_battle_ships_on_swars_battle_record_id | false  | ["swars_battle_record_id"]                         | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | index_swars_battle_ships_on_swars_battle_user_id   | false  | ["swars_battle_user_id"]                           | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | index_swars_battle_ships_on_swars_battle_grade_id  | false  | ["swars_battle_grade_id"]                          | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | index_swars_battle_ships_on_judge_key              | false  | ["judge_key"]                                      | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | index_swars_battle_ships_on_location_key           | false  | ["location_key"]                                   | {}      |        |       |      | btree |         |
# >> | swars_battle_ships | index_swars_battle_ships_on_position               | false  | ["position"]                                       | {}      |        |       |      | btree |         |
# >> |--------------------+----------------------------------------------------+--------+----------------------------------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> swars_battle_users
# >> |--------------------+---------------------------------------------------+--------+---------------------------+---------+--------+-------+------+-------+---------|
# >> | table              | name                                              | unique | columns                   | lengths | orders | where | type | using | comment |
# >> |--------------------+---------------------------------------------------+--------+---------------------------+---------+--------+-------+------+-------+---------|
# >> | swars_battle_users | index_swars_battle_users_on_user_key                   | true   | ["user_key"]                   | {}      |        |       |      | btree |         |
# >> | swars_battle_users | index_swars_battle_users_on_swars_battle_grade_id | false  | ["swars_battle_grade_id"] | {}      |        |       |      | btree |         |
# >> |--------------------+---------------------------------------------------+--------+---------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> swars_battle_user_receptions
# >> |------------------------------------+------------------------------------------------------------------+--------+--------------------------+---------+--------+-------+------+-------+---------|
# >> | table                              | name                                                             | unique | columns                  | lengths | orders | where | type | using | comment |
# >> |------------------------------------+------------------------------------------------------------------+--------+--------------------------+---------+--------+-------+------+-------+---------|
# >> | swars_battle_user_receptions | index_swars_battle_user_receptions_on_swars_battle_user_id | false  | ["swars_battle_user_id"] | {}      |        |       |      | btree |         |
# >> |------------------------------------+------------------------------------------------------------------+--------+--------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> taggings
# >> |----------+-------------------------------------------------------------+--------+-----------------------------------------------------------------------------------+---------+--------+-------+------+-------+---------|
# >> | table    | name                                                        | unique | columns                                                                           | lengths | orders | where | type | using | comment |
# >> |----------+-------------------------------------------------------------+--------+-----------------------------------------------------------------------------------+---------+--------+-------+------+-------+---------|
# >> | taggings | taggings_idx                                                | true   | ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"] | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_taggable_id_and_taggable_type_and_context | false  | ["taggable_id", "taggable_type", "context"]                                       | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_tag_id                                    | false  | ["tag_id"]                                                                        | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_taggable_id                               | false  | ["taggable_id"]                                                                   | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_taggable_type                             | false  | ["taggable_type"]                                                                 | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_tagger_id                                 | false  | ["tagger_id"]                                                                     | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_context                                   | false  | ["context"]                                                                       | {}      |        |       |      | btree |         |
# >> | taggings | index_taggings_on_tagger_id_and_tagger_type                 | false  | ["tagger_id", "tagger_type"]                                                      | {}      |        |       |      | btree |         |
# >> | taggings | taggings_idy                                                | false  | ["taggable_id", "taggable_type", "tagger_id", "context"]                          | {}      |        |       |      | btree |         |
# >> |----------+-------------------------------------------------------------+--------+-----------------------------------------------------------------------------------+---------+--------+-------+------+-------+---------|
# >> 
# >> tags
# >> |-------+--------------------+--------+----------+---------+--------+-------+------+-------+---------|
# >> | table | name               | unique | columns  | lengths | orders | where | type | using | comment |
# >> |-------+--------------------+--------+----------+---------+--------+-------+------+-------+---------|
# >> | tags  | index_tags_on_name | true   | ["name"] | {}      |        |       |      | btree |         |
# >> |-------+--------------------+--------+----------+---------+--------+-------+------+-------+---------|
