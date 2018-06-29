# チャットルーム一覧
class LobbyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "lobby_channel" # ブロードキャストするにはこれが必要
    stream_for current_user
  end

  def unsubscribed
  end

  def chat_say(data)
    current_user.lobby_chat_say(data["message"], msg_options: data["msg_options"])
  end

  def setting_save(data)
    current_user.update!({
        lifetime_key:    data["lifetime_key"],
        platoon_key:     data["platoon_key"],
        self_preset_key: data["self_preset_key"],
        oppo_preset_key: data["oppo_preset_key"],
      })
  end

  def matching_start(data)
    current_user.matching_start
  end

  def matching_cancel(data)
    current_user.update!(matching_at: nil)
  end
end
