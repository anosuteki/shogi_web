class FlashInfo
  # flash[:xxx] で使うキー
  # https://buefy.org/documentation/notification
  cattr_accessor :notify_keys do
    [
      :default,
      :primary,
      :link,
      :info,
      :success,
      :warning,
      :danger,
    ]
  end

  # Rails から Buefy のキーに置き換える
  cattr_accessor :rails_default_keys do
    {
      "notice" => "success",
      "alert"  => "warning",
      "error"  => "danger",
    }
  end

  cattr_accessor :toast_keys do
    notify_keys.collect { |e| "toast_#{e}".to_sym }
  end

  cattr_accessor :flash_all_keys do
    notify_keys + toast_keys
  end

  delegate :tag, :params, :flash, :content_tag, to: :view_context

  attr_accessor :view_context

  def initialize(view_context)
    @view_context = view_context

    if params[:debug]
      FlashInfo.flash_all_keys.each do |e|
        flash.now[e] = e.to_s
      end
    end
  end

  def normalized_flash
    @normalized_flash ||= flash.to_h.transform_keys do |e|
      e.to_s.sub(Regexp.union(rails_default_keys.keys), rails_default_keys).to_sym
    end
  end

  # 危険通知は notification を使う
  def flash_danger_notify_tag
    if list = normalized_flash.slice(*notify_keys).presence
      tag.div(id: "flash_danger_notify_tag", :class => "is_screen_only") do
        list.collect { |key, message|
          content_tag("b-notification", message.html_safe, type: "is-#{key}", ":has-icon": "false", ":closable": "false")
        }.join.html_safe
      end
    end
  end

  # 軽いもの success, info は toast を使う
  def flash_light_notify
    normalized_flash.slice(*toast_keys).transform_keys { |e| e.to_s.remove(/^toast_/) }
  end
end
