Kajipin::Application.routes.draw do

  # USERS
  devise_for :users, :path => "", :controllers => { :registrations => :registrations }

  resources :users, :only => [:index, :show] do
    resources :pins, :only => [:index], :defaults => { :format => 'json' }
  end

  authenticated :user do
    root :to => "users#show"
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  # PINS
  resources :pins, :only => [:new, :update, :create, :destroy] do
    resources :photos, :only => [:index, :new] do
      get 'captain', :on => :collection
      post 'create_many', :on => :collection
      delete 'destroy_many', :on => :collection
      delete 'destroy_all', :on => :collection
    end
    resources :comments, :only => [:index, :create, :destroy]
  end

  # FRIENDSHIPS
  resources :friendships, :only => [:index, :create, :destroy]

  resources :requests, :only => [:index, :create, :destroy] do
    post 'approve', :on => :member
  end

  # AVATARS
  resources :avatars, :only => [:new, :create, :destroy]

  # GEONAMES
  resources :geonames, :only => [:index], :defaults => { :format => 'json' }

  # HERALDS
  resources :heralds, :only => [:index, :create] do
    get 'photos', :on => :collection
    get 'comments', :on => :collection
    get 'logpages', :on => :collection
    delete 'destroy', :on => :collection
  end
  match "/:key" => "heralds#show"

end