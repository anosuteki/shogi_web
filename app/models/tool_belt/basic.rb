module ToolBelt
  class Basic < Base
    private

    def build
      out = super

      out << h.tag.div(:class => "buttons") do
        [
          link_to_eval("ユーザーセットアップ")                                { "Colosseum::User.setup"                                                   },
          link_to_eval("ユーザー全削除")                                      { "Colosseum::User.destroy_all"                                             },
          link_to_eval("ユーザー追加")                                        { "Colosseum::User.create!"                                                 },
        ].compact.join.html_safe
      end

      list = Colosseum::User.all.limit(25).collect do |e|
        {}.tap do |row|
          row[:name] = e.name
          row["操作"] = [
            link_to_eval("login", redirect_to: :root)    { "current_user_set_id(#{e.id})"                                                    },
            link_to_eval("削除", redirect_to: :root)     { "Colosseum::User.find(#{e.id}).destroy!"                                          },
            link_to_eval("logout", redirect_to: :root)   { "reset_session" if e == h.current_user                                            },
          ].compact.join(" ").html_safe
        end
      end

      out << list.to_html

      hash = {
        "action_cable_meta_tag" => "" + h.action_cable_meta_tag,
      }

      out << hash.to_html
      out
    end
  end
end
