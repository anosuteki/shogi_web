# app/channels/acns2/lobby_channel.rb
# app/jobs/acns2/lobby_broadcast_job.rb
# app/jobs/acns2/message_broadcast_job.rb
# app/jobs/message_broadcast_job.rb
# app/models/acns2/membership.rb
# app/models/acns2/user.rb
# app/models/backend_script/acns2_sample_script.rb
# app/models/backend_script/action_cable_info_script.rb
# app/models/colosseum/user_acns2_mod.rb
# app/models/colosseum/user_chronicle_methods.rb
# experiment/0850_acns2.rb
module BackendScript
  class Acns2SampleScript < ::BackendScript::Base
    include AtomicScript::AddJsonLinkMod

    self.script_name = "詰将棋ファイター"

    def form_parts
      [
        {
          :label   => "画面",
          :key     => :debug_scene,
          :elems   => { "ロビー" => nil, "YOU WIN" => :room_owari },
          :type    => :select,
          :default => current_debug_scene,
        },
      ]
    end

    def script_body
      Acns2.setup

      out = ""

      # return ActionCable.server.open_connections_statistics
      # .map { |con| con[:subscriptions]
      #   .map { |sub| JSON.parse(sub)["url"] } } # ここのurlを変えれば特定の接続数を取得できるはず
      # .flatten
      # .select { |url| url == 'http:himakannet' } # ここで特定のチャネル一致
      # .size

      if request.format.json?
      end

      # if !current_room
      #   out += Acns2::Room.order(:id).collect { |room|
      #     {
      #       "チャットルーム" => h.link_to(room.id, params.merge(room_id: room.id)),
      #     }
      #   }.to_html
      # end

      if current_room
        #   messages = current_room.messages.order(:id).last(10)
        #   rendered_messages = messages.collect { |message|
        #     ApplicationController.renderer.render partial: 'acns2/messages/message', locals: { message: message }
        #   }
      end

      info = {}

      if true
        info[:debug_scene] = current_debug_scene

        case current_debug_scene
        when :room_owari
          c.current_user_set_sysop_unless_logout

          user = Colosseum::User.create!
          room = Acns2::Room.create! do |e|
            e.memberships.build(user: h.current_user, judge_key: :win)
            e.memberships.build(user: user, judge_key: :lose)
          end

          info[:mode] = "room_owari"
          info[:room] = room.as_json(only: [:id], include: { memberships: { only: [:id, :judge_key, :rensho_count, :renpai_count], include: {user: { only: [:id, :name], methods: [:avatar_url] }} } })
        end
      end

      info[:mode] ||= "lobby"

      if h.current_user
        info[:current_user] = h.current_user.as_json(only: [:id, :name], methods: [:avatar_url])
      end

      # info[:room] = current_room
      # info[:messages] = rendered_messages
      if request.format.json?
        return info
      end
      #
      out += h.javascript_tag(%(document.addEventListener('DOMContentLoaded', () => { new Vue({}).$mount("#app") })))
      out += %(<div id="app"><acns2_sample :info='#{info.to_json}' /></div>)
      # out += h.tag.br
      # out += h.link_to("ロビー", params.merge(room_id: nil), :class => "button is-small")
      # end

      out
    end

    def current_room_id
      params[:room_id].presence
    end

    def current_room
      if v = current_room_id
        Acns2::Room.find_by(id: v)
      end
    end

    def current_debug_scene
      if v = params[:debug_scene].presence
        v.to_sym
      end
    end
  end
end
