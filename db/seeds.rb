ENV["SLACK_AGENT_DISABLE"] = "1"

[
  Actf,
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
  Acns1,
].each do |e|
  e.setup
end
