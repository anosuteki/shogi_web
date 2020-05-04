module ToolBelt
  class Basic < Base
    private

    def build
      out = super

      out << {
        "リンク"                => [
          link_to_eval("発言", redirect_to: :root)  { "current_user.acns1_messages.create!(body: SecureRandom.hex)"},
          h.link_to("sidekiq", "/admin/sidekiq", :class => "button is-small"),
        ].join(" ").html_safe,
        "action_cable_meta_tag" => "" + h.action_cable_meta_tag,
        "Acns1::Message.count"  => Acns1::Message.count,
      }.to_html

      out << Colosseum::User.all.limit(25).collect { |e|
        {}.tap do |row|
          row[:name] = e.name
          row["操作"] = [
            link_to_eval("login", redirect_to: :root)    { "current_user_set_id(#{e.id})"            },
            link_to_eval("logout", redirect_to: :root)   { "reset_session" if e == h.current_user    },
          ].compact.join(" ").html_safe
        end
      }.to_html

      out
    end
  end
end
