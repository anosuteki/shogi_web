module BackendScript
  class ActbDirectUserSwitchScript < ::BackendScript::Base
    self.category = "actb"
    self.script_name = "将棋トレバト 運営切り替え (直接)"
    self.visibility_hidden = true

    def script_body
      user = User.find_by!(key: params[:user_key])
      c.current_user_set(user)
      c.redirect_to params[:redirect_to]
    end
  end
end
