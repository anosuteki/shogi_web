module ResourceNs1
  concern :SharedMethods do
    included do
      if Rails.env.production?
        if v = ENV["HTTP_BASIC_AUTHENTICATE"].presence
          http_basic_authenticate_with Hash[[:name, :password].zip(v.split(/:/))].merge(only: [:edit, :update, :destroy])
        end
      end

      rescue_from "Warabi::WarabiError" do |exception|
        h = ApplicationController.helpers
        lines = exception.message.lines
        message = lines.first.strip.html_safe
        if field = lines.drop(1).presence
          message += h.tag.div(field.join.html_safe, :class => "error_message_pre").html_safe
        end
        if v = exception.backtrace
          message += h.tag.div(v.first(8).join("\n").html_safe, :class => "error_message_pre").html_safe
        end
        behavior_after_rescue(message)
      end
    end

    def show
      access_log_create

      if params[:mountain]
        current_record.mountain_post_once
        render json: {url: current_record.mountain_url}
        return

        # 通常リンク(remote: false)の場合
        if true
          if request.format.html?
            if current_record.mountain_url
              redirect_to current_record.mountain_url
            else
              # 無限ループしないように fallback_location に mountain を含めないこと
              # redirect_back を使うと referer に mountain に含まれていて無限ループするはずなので注意
              raise MustNotHappen if params[:fallback_location].to_s.include?("mountain")
              redirect_to params[:fallback_location], notice: "混み合っているようです"
            end
            return
          end
        end

        logger.info({mountain_url: current_record.mountain_url}.to_t)
        render "resource_ns1/swars_battle_records/show"
        return
      end

      respond_to do |format|
        format.html
        format.any { kifu_send_data }
      end
    end

    private

    def current_filename
      "#{current_record.battle_key}.#{params[:format]}"
    end

    def kifu_send_data
      text_body = nil
      if converted_info = current_record.converted_infos.find_by(text_format: params[:format])
        text_body = converted_info.text_body
      end

      if params[:shift_jis].present? || params[:sjis].present?
        text_body = text_body.tosjis
      end

      if params[:plain].present?
        render plain: text_body
      else
        if params[:inline].present?
          disposition = "inline"
        else
          disposition = "attachment"
        end
        send_data(text_body, type: Mime[params[:format]], filename: current_filename.encode(current_encode), disposition: disposition)
      end
    end

    def current_encode
      params[:encode].presence || current_encode_default
    end

    def current_encode_default
      if request.user_agent.to_s.match(/Windows/i)
        "Shift_JIS"
      else
        "UTF-8"
      end
    end

    def behavior_after_rescue(message)
      redirect_to :root, danger: message
    end

    def access_log_create
    end
  end
end
