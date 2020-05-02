class ApplicationController < ActionController::Base
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  concerning :ChoreMethods do
    included do
      helper_method :submitted?
    end

    def submitted?(name)
      params.key?(name)
    end

    private

    def boolean_for(v)
      v.to_s == "true" || v.to_s == "1"
    end

    def h
      @h ||= view_context
    end
    delegate :tag, :link_to, :icon_tag, :auto_link, to: :h
  end

  concerning :CurrentUserMethods do
    included do
      helper_method :current_user
    end

    let :current_user do
      user = nil
      id = session[:user_id]
      id ||= cookies.encrypted[:user_id]
      if id
        user ||= Colosseum::User.find_by(id: id)
      end
      user ||= current_xuser

      # if user
      #   cookies.encrypted[:user_id] = {value: user.id, expires: 1.years.from_now}
      # end

      user
      # end
    end

    def current_user_set_id(user_id)
      if instance_variable_defined?(:@current_user)
        remove_instance_variable(:@current_user)
      end

      if user_id
        session[:user_id] = user_id
      else
        session.delete(:user_id)
      end

      if user_id
        cookies.encrypted[:user_id] = { value: user_id, expires: 1.years.from_now }
      else
        cookies.delete(:user_id)
      end
    end

    def current_user_logout
      if current_user
        current_user.lobby_out_handle
      end
      current_user_set_id(nil)
      sign_out(:xuser)
    end
  end
end
