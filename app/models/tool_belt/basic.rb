module ToolBelt
  class Basic < Base
    private

    def build
      out = super

      if v = h.content_for(:twitter_card_registry)
        out << h.tag.b("twitter_card_registry")
        out << h.tag.pre(v.gsub(/\>/, ">\n"))
      end

      out << h.tag.div(:class => "buttons") do
        [
          link_to_eval("ユーザーセットアップ")                                { "Colosseum::User.setup"                                                   },
          link_to_eval("ユーザー全削除")                                      { "Colosseum::User.destroy_all"                                             },
          link_to_eval("ユーザー追加")                                        { "Colosseum::User.create!"                                                 },
          link_to_eval("1 + 2")                                               { "1 + 2"                                                                   },
          link_to_eval("1 / 0", redirect_to: :root)                           { "1 / 0"                                                                   },
          link_to_eval("flash確認", redirect_to: h.root_path(debug: "true"))  { ""                                                                        },

        ].compact.join.html_safe
      end

      list = Colosseum::User.all.limit(25).collect do |e|
        {}.tap do |row|
          row[:id] = h.link_to(e.id, e)
          row[:name] = h.link_to(e.name, e)
          row["操作"] = [
            link_to_eval("login", redirect_to: :root)    { "current_user_set_id(#{e.id})"                                                    },
            link_to_eval("削除", redirect_to: :root)     { "Colosseum::User.find(#{e.id}).destroy!"                                          },
            link_to_eval("logout", redirect_to: :root)   { "reset_session" if e == h.current_user                                            },
          ].compact.join(" ").html_safe
        end
      end

      out << list.to_html
    end
  end
end
