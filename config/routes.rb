Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "users/confirm", to: "users#confirm"
  resources :users, param: :user_name, except: [:signup]
  get "/signup", to: "users#new"
  get "/login", to: "authentication#new"
  post "/auth/login", to: "authentication#login"
  get "/*a", to: "application#not_found"
end

