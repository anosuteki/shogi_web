require "./setup"
Xclock.setup(force: true)

user1 = User.create!
user2 = User.create!
question1 = user1.xclock_questions.create_mock1
room = Xclock::Room.create_with_members!([user1, user2])
battle = room.battle_create_with_members!
history = user1.xclock_histories.create!(question: question1, ox_mark: Xclock::OxMark.fetch(:correct))
Xclock::LobbyMessage.last         # => #<Xclock::LobbyMessage id: 51, user_id: 2, body: "<a href=\"/training?user_id=67\">名無しの棋士60号</a>さんが本日1...", created_at: "2020-08-09 03:01:25", updated_at: "2020-08-09 03:01:25">
