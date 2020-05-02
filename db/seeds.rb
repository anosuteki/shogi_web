ENV["SLACK_AGENT_DISABLE"] = "1"

[
  Colosseum::User,
  Acns1,
].each do |e|
  e.setup
end
