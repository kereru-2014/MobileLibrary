Rails.application.routes.draw do

  devise_for :users
  root to: "static#app"
  apipie


  scope "/api/v1" do
    resources :users
    resources :borrowers, only: [:show, :edit, :index, :destroy]


    resources :books do
      member do
        post 'lend'
        post 'return'
      end
        resources :borrowers, shallow: true
      end
  end
end
