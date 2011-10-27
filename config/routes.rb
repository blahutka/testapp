# -*- encoding : utf-8 -*-
Dumsnadno::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  resources :skill_requirements, :except => :index do
    new do
      get 'skill'
    end
  end

  get "users/index"

  resources :homes do
    collection do
      get 'worker'
    end
  end

  resources :users do
    member do
      get :activate
    end
  end

  resources :user_sessions
  
  resources :password_resets

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resource :oauth do
    get :callback
  end
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root :to => 'homes#index'
end
