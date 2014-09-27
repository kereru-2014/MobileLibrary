Rails.application.routes.draw do

  devise_for :users
  root to: "static#app"
  apipie

  root 'pages#index'

  scope "/api/v1" do
    resources :books
  end
end
