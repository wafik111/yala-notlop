Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  get 'welcome/index'
  resources :users, only: [:show]

  post "/orders/invite.json", to: "invited_members#invite"

  resources :orders do
    get "/joined/", to: "order_informations#index"
    post"/add/", to: "order_informations#create"
    get "/invited/", to: "invited_members#index"
  end

  resources :groups do
    resources :members
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
