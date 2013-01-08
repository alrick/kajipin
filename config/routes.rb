Kajipin::Application.routes.draw do
  devise_for :users, :path => "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "join"}

  resources :friendships

  resources :accesstokens, :path => 'services' do
    collection do
      get 'dropbox'
    end
  end

  resources :pins do
    resources :comments
    resources :galleries
    resources :logpages, :path => 'logbook' do
      collection do
        get 'manage'
      end
    end
  end

  resources :users

  authenticated :user do
    root :to => "users#show"
  end
  unauthenticated :user do
    devise_scope :user do 
      get "/" => "devise/sessions#new"
    end
  end
  
  match "friends" => "friendships#index"

end