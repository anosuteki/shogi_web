Rails.application.routes.draw do
  devise_for :xusers, {
    class_name: "Colosseum::User",
  }

  root "admin/scripts#show", { id: :acns1_sample }

  ################################################################################ Debug

  match 'eval', to: "eval#run", via: [:get, :post, :put, :delete]

  ################################################################################ ログアウト

  direct :production_app do
    "https://shogi-flow.xyz/"
  end

  direct :staging_app do
    "https://staging.shogi-extend.com/"
  end

  ################################################################################ admin

  namespace :admin do
    resource :session, only: :destroy
    resource :home, only: :show

    resources :scripts, path: "script", only: [:show, :update]

    resources :example_scripts, path: "example-script", only: [:show, :update]

    root "homes#show"
  end

  ################################################################################ sidekiq

  # require 'sidekiq/monitor/stats' # <mounted-path>/monitor-stats
  require 'sidekiq/web'
  mount Sidekiq::Web => '/admin/sidekiq' # authenticate :user {} で認証チェックする例がネットにあるが、それは devise のメソッド

  if false
    # Sidekiq::Web.tabs.replace({"管理画面" => "/admin"}.merge(Sidekiq::Web.tabs))
    # Sidekiq::Web.tabs["管理画面に戻る"] = "/admin"
    Sidekiq::Web.tabs["管理画面に戻る"] = "http://localhost:3000/admin"
  end
end
