CommitNotifier::Application.routes.draw do

  devise_for :users

  root :to => "home#index"

  resources :users, :only => [ :index, :show ] do
    resources :events, :only => [ :new, :show, :create, :index ]
    match 'followers', :to => 'followings#followers', :as => 'followers'
    match 'following', :to => 'followings#following', :as => 'following'
  end

  resources :followings, :only => [ :index, :edit, :update ]

  match 'following/:followed_user_id', 
        :via => 'post', 
        :to  => 'followings#create', 
        :as  => 'create_following'

  resources :notifications, :only => [ :index ]

  resources :search_results, :only => [ :index ]

  resources :integrations, :only => [ :index, :show ]

  match 'integrations/downloads/:api_key/gcs/post-commit',
        :to => 'integrations/downloads/git_client_side#post_commit',
        :as => 'integrations/downloads/gcs_pc'
  
  resources :integration_downloads, :only => [ :show ]

  namespace :api do

    resources :users, :only => [ :index, :show ] do
      resources :events, :only => [ :new, :create ]
    end

  end

end
