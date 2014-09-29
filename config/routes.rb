Rails.application.routes.draw do

  devise_for :users
  root to: "static#app"
  apipie

  # root 'pages#index'

  scope "/api/v1" do
    resources :users
    resources :borrowers, only: [:show, :edit, :index, :destroy]
end
    # resources :books do
    #   resources :borrowers
    # end

    # resources :books do
    #   collection do
    #     post 'lend'
    #     post 'return'
    #   end
    # end

    resources :books do
      member do
        post 'lend'
      end
      resources :borrowers, shallow: true
    end
end
