module Admin
  class SessionsController < ::Admin::ApplicationController
    def destroy
      if admin_user
        session.delete(:admin_user)
        notice = "ログアウトしました。"
      else
        notice = "すでにログアウトしています。"
      end
      redirect_to :root, :notice => notice
    end
  end
end
