# -*- encoding : utf-8 -*-
Dumsnadno::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"


  get "users/index"

  resources :homes
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


  #root :to => "homes#index", :constraints => LoggedInConstraint.new(false)


  # LOGGED USER
  #scope '/account', :module => 'account', :constraints => lambda { |req| req.session.include?(:user_id) } do
  #  #scope '/account' do
  #  match 'dashboard' => 'dashboard#index', :as => :dashboard, :module => 'account'
  #  match 'home' => 'dashboard#index', :as => :home
  #  resources :skill_requests, :shallow => true, :modul => :account do
  #    #resources :skill_requirements, :except => :new
  #  end
  #
  #  resources :skill_requirements
  #
  #  #end
  #end

  # LOGGED USER
  scope :constraints => lambda { |req| req.session.include?(:user_id) } do
    match 'dashboard' => 'account/dashboard#index', :as => :dashboard
    match 'home' => 'account/dashboard#index', :as => :home
    resources :skill_requirements, :module => 'account'
  end

  scope '/account', :module => 'account' do
    resources :skill_requests
  end

  # NOT LOGGED USER
  match 'home' => 'homes#index', :as => :home
  resources :skill_requirements do
    new do
      get 'skill'
    end
  end


  root :to => 'homes#index'


end