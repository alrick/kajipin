Kajipin::Application.routes.draw do

  devise_for :users, :path => "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "join"}

  resources :users, :only => [:index, :show]

  authenticated :user do
    root :to => "users#show"
  end
  unauthenticated :user do
    devise_scope :user do 
      get "/" => "devise/sessions#new"
    end
  end

  resources :pins, :only => [:index, :new, :update, :create, :destroy] do
    collection do
      get 'list'
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

  resources :requests, :only => [:index, :create, :destroy]

end