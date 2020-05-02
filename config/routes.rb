Rails.application.routes.draw do
  mount ActionCable.server => '/cable2'

  devise_for :xusers, {
    class_name: "Colosseum::User",
  }

  # root "colosseum/battles#index"
  root "admin/scripts#show", { id: :acns1_sample }

  ################################################################################ Debug

  match 'eval', to: "eval#run", via: [:get, :post, :put, :delete]

  ################################################################################ ログアウト

  resolve "Swars::User" do |user, options|
    swars_basic_path(query: user.to_param)
  end

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
end
