ENV["SLACK_AGENT_DISABLE"] = "1"

[
  FreeBattle,
  Swars::Grade,
  Swars::Battle,
  Colosseum::User,
  Colosseum::Battle,
  Colosseum::ChatMessage,
  Colosseum::LobbyMessage,
  XyRuleInfo,
  XyRecord,
  Tsl,
].each do |e|
  e.setup
end
