Rails.application.routes.draw do

  devise_for :users
  root to: "static#app"
  apipie

  # Don't commit commented out code.
  # root 'pages#index'

  scope "/api/v1" do
    # I find it better to have each resource on it's own line
    # Also if you are not using users for any other purpose
    # besides for devise then you don't need to have routes for
    # it here as well. Devise will take care of the user routes
    # it needs with `devise_for` above.
    resources :books, :borrowers, :users
  end
end
