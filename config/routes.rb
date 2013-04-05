Kajipin::Application.routes.draw do

  resources :avatars


  devise_for :users, :path => ""

  resources :users, :only => [:index, :show] do
    get 'modal', :on => :member
  end

  authenticated :user do
    root :to => "users#show"
  end
  unauthenticated :user do
    devise_scope :user do 
      get "/" => "devise/sessions#new"
    end
  end

  resources :pins, :only => [:index, :new, :update, :create, :destroy] do
    get 'list', :on => :collection
    resources :photos, :only => [:index, :new] do
      get 'captain', :on => :collection
      post 'create_many', :on => :collection
      delete 'destroy_many', :on => :collection
    end
    resources :comments, :only => [:index, :create, :destroy]
    resources :logpages, :only => [:index, :create, :update, :destroy], :path => 'logbook' do
      collection do
        get 'captain'
        get 'cancel'
      end
    end
  end

  resources :friendships, :only => [:index, :create, :destroy]

  resources :requests, :only => [:index, :create, :destroy] do
    post 'approve', :on => :member
  end

  match 'tos' => 'static#terms'

end