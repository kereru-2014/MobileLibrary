Rails.application.routes.draw do

  devise_for :users
  root to: "static#app"
  apipie


  scope "/api/v1" do
    get "/users/:id/overdue" => "users#overdue"

    resources :borrowers

    resources :books do
      member do
        patch 'lend'
        patch 'return'
      end
      collection do
        get 'find'
      end
      resources :borrowers, shallow: true
    end
  end
end
