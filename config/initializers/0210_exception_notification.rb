if Rails.env.production? || Rails.env.staging? || ENV["EXCEPTION_NOTIFICATION_ENABLE"].to_s == "1" # || Rails.env.development?
  Rails.application.config.middleware.use(ExceptionNotification::Rack, {
      # ignore_exceptions: ExceptionNotifier.ignored_exceptions - ["ActiveRecord::RecordNotFound"], # 404 のエラーも通知する
      ignore_exceptions: ExceptionNotifier.ignored_exceptions - [],

      email: {
        :email_prefix         => "[shogi_web #{Rails.env}] ",
        :sender_address       => "pinpon.ikeda@gmail.com",
        :exception_recipients => %w{pinpon.ikeda@gmail.com},
      },
    })
end
