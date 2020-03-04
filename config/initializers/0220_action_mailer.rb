if Rails.env.production? || Rails.env.staging? || Rails.env.development?
  Rails.application.configure do
    config.app_config.deep_merge!({admin_email: "pinpon.ikeda@gmail.com"})

    case
    when Rails.env.production?
      config.action_mailer.default_url_options.update(protocol: "https", host: "www.shogi-extend.com")
    when Rails.env.staging?
      config.action_mailer.default_url_options.update(protocol: "https", host: "staging.shogi-extend.com")
    else
      config.action_mailer.default_url_options.update(port: 3000, host: host)
    end

    config.action_mailer.show_previews = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_caching = true
    config.action_mailer.smtp_settings = {
      enable_starttls_auto: true,
      address: "smtp.gmail.com",
      domain: "smtp.gmail.com",
      port: 587,
      authentication: "plain",
      user_name: "pinpon.ikeda",
      password: Rails.application.credentials[:gmail_smtp_password],
    }
  end
end
