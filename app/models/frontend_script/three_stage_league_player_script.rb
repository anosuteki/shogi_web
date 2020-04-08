module FrontendScript
  class ThreeStageLeaguePlayerScript < ::FrontendScript::Base
    self.script_name = "奨励会三段リーグ(個人別)"

    def form_parts
      [
        {
          :label   => "名前",
          :key     => :user_name,
          :elems   => Tsl::User.order(:name).inject({}) { |a, e| a.merge(e.name_with_age => e.name) },
          :type    => :select,
          :default => current_user_name,
        },
      ]
    end

    def script_body
      if current_uesr
        s = current_uesr.memberships
        s = s.joins(:league).includes(:user, :league)
        s = s.order(Tsl::League.arel_table[:generation].asc)

        if request.format.json?
          return s.as_json(include: [:user, :league], except: [:league_id, :user_id])
        end

        memberships = s

        data = {
          labels: memberships.collect { |e| e.league.generation },
          datasets: [
            {
              label: current_uesr.name,
              data: memberships.collect { |e| e.win },
            },
          ],
        }

        info = {
          memberships: memberships,
          data: data,
        }

        out = ""
        out += h.javascript_tag(%(document.addEventListener('DOMContentLoaded', () => { new Vue({}).$mount("#app") })))
        out += %(<div id="app"><three_stage_league_player_chart :info='#{info.to_json}' /></div>)
        out
      end
    end

    def buttun_name
      "表示"
    end

    def current_user_name
      params[:user_name].presence || Tsl::User.order(:name).first&.name
    end

    def current_uesr
      if v = current_user_name
        Tsl::User.find_by!(name: v)
      end
    end
  end
end
