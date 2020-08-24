require "./setup"

require "./setup"

Xclock::Question.destroy_all

user1 = User.create!
user2 = User.create!

question1 = user1.xclock_questions.create_mock1
question1.messages.create!(user: user1, body: "message") # => #<Xclock::QuestionMessage id: 28, user_id: 140, question_id: 58, body: "message", created_at: "2020-06-25 06:50:49", updated_at: "2020-06-25 06:50:49">
