Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/cart', to: "carts#show"
  delete '/cart', to: "carts#destroy"
  patch '/cart/item', to: "carts#update"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', as: :registration, to: "users#new"
  delete '/logout', to: "sessions#destroy"
  get '/merchants', as: :merchants, to: "users#index"


  resources :items, only: [:index, :show]
  resources :users, only: [:create, :update]
  resources :carts, only: [:create]

  namespace :admin do
    resources :users, only: [:index, :show, :update, :edit] do
      patch '/enable', to: "users#enable"
      patch '/upgrade', to: "users#upgrade"
    end

    resources :orders, only: [:show, :update]

    resources :merchants, only: [:index, :show, :update] do
      patch '/enable', to: "merchants#update"
      patch '/downgrade', to: "merchants#downgrade"
      resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :orders, only: [:show, :update]
    end
  end

  namespace :profile do
    resources :orders, only: [:show, :create, :update]
    get '/', to: "users#show"
    get '/edit', to: "users#edit"
  end

  namespace :dashboard do
    resources :items, only: [:index, :edit, :update, :new, :create, :destroy]
    resources :orders, only: [:show]
    resources :order_items, only: [:update]
    get '/', to: "users#show"
  end

end
