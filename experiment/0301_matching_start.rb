#!/usr/bin/env ruby
require File.expand_path('../../config/environment', __FILE__)

module Fanta
  User.destroy_all
  Battle.destroy_all

  alice = User.create!
  bob = User.create!(behavior_key: :yowai_cpu)
  alice.battle_with(bob)
end
# >> D, [2018-06-28T19:09:16.789107 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 361, name: "野良2号", current_battle_id: 234, online_at: "2018-06-28 10:01:46", fighting_at: "2018-06-28 10:01:46", matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: "yowai_cpu", created_at: "2018-06-28 10:01:46", updated_at: "2018-06-28 10:01:46">
# >> I, [2018-06-28T19:09:16.789731 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.52ms)
# >> D, [2018-06-28T19:09:16.809083 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 362, name: "野良3号", current_battle_id: nil, online_at: "2018-06-28 10:03:34", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p2vs2", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:03:34", updated_at: "2018-06-28 10:03:34">
# >> I, [2018-06-28T19:09:16.809567 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.43ms)
# >> D, [2018-06-28T19:09:16.822600 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 363, name: "野良4号", current_battle_id: nil, online_at: "2018-06-28 10:03:34", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p2vs2", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:03:34", updated_at: "2018-06-28 10:03:34">
# >> I, [2018-06-28T19:09:16.822856 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.21ms)
# >> D, [2018-06-28T19:09:16.836568 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 364, name: "弱いCPU", current_battle_id: 237, online_at: "2018-06-28 10:03:34", fighting_at: "2018-06-28 10:08:32", matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: "yowai_cpu", created_at: "2018-06-28 10:03:35", updated_at: "2018-06-28 10:08:32">
# >> I, [2018-06-28T19:09:16.836777 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.13ms)
# >> I, [2018-06-28T19:09:16.873418 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with ActiveModelSerializers::Adapter::Attributes (0.12ms)
# >> D, [2018-06-28T19:09:16.927395 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:16.927577 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.12ms)
# >> D, [2018-06-28T19:09:16.938499 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:16.938791 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.23ms)
# >> D, [2018-06-28T19:09:16.984271 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:16.984622 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.28ms)
# >> D, [2018-06-28T19:09:16.989961 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:16.990551 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.54ms)
# >> D, [2018-06-28T19:09:17.040985 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:17.053933 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.23ms)
# >> D, [2018-06-28T19:09:17.062089 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:17.062423 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.28ms)
# >> D, [2018-06-28T19:09:17.074286 #34264] DEBUG -- : No serializer found for resource: #<Fanta::User id: 365, name: "野良1号", current_battle_id: nil, online_at: "2018-06-28 10:09:16", fighting_at: nil, matching_at: nil, lifetime_key: "lifetime_m5", platoon_key: "platoon_p1vs1", self_preset_key: "平手", oppo_preset_key: "平手", user_agent: "", behavior_key: nil, created_at: "2018-06-28 10:09:16", updated_at: "2018-06-28 10:09:16">
# >> I, [2018-06-28T19:09:17.074563 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with Fanta::User::ActiveRecord_Relation (0.22ms)
# >> I, [2018-06-28T19:09:19.128647 #34264]  INFO -- : Rendered ActiveModel::Serializer::CollectionSerializer with ActiveModelSerializers::Adapter::Attributes (2021.36ms)
# >> ["/Users/ikeda/src/shogi_web/app/models/fanta/battle.rb:179", :saisyonisasu, "position sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b - 1", 0]
# >> ["/Users/ikeda/src/shogi_web/app/models/fanta/battle.rb:265", :sasimasu, <▲９六歩(97)>]
# >> ["/Users/ikeda/src/shogi_web/app/models/fanta/battle.rb:187", :saisyonisasu, "position startpos moves 9g9f"]
