Kajipin::Application.routes.draw do

  # USERS
  devise_for :users, :path => "", :controllers => { :registrations => :registrations }

  resources :users, :only => [:index, :show]

  authenticated :user do
    root :to => "users#show"
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  # PINS
  resources :pins, :only => [:show, :new, :update, :create, :destroy] do
    resources :photos, :only => [:new] do
      get 'captain', :on => :collection
      post 'create_many', :on => :collection
      delete 'destroy_many', :on => :collection
      delete 'destroy_all', :on => :collection
    end
    resources :comments, :only => [:create, :destroy]
  end

  # FRIENDSHIPS
  resources :friendships, :only => [:index, :create, :destroy]

  # REQUESTS
  resources :requests, :only => [:index, :create, :destroy] do
    post 'approve', :on => :member
  end

  # AVATARS
  resources :avatars, :only => [:new, :create, :destroy]

  # GEONAMES
  resources :geonames, :only => [:index], :defaults => { :format => 'json' }

  # HERALDS
  resources :heralds, :only => [:index, :create] do
    delete 'destroy', :on => :collection
  end
  match "/:key" => "users#show"

end