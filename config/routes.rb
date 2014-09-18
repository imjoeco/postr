RailsApp::Application.routes.draw do
  resources :sessions 
  
  resources :comments do
    member do
      get 'vote'
    end
  end
  
  resources :users do
    member do
      get 'recent_list'
      get 'top_comments'
      get 'top_posts'
    end
  end

  resources :posts do
    resources :comments
    resources :post_votes

    collection do
      get 'favorites'
      get 'daily'
      get 'weekly'
    end

    member do
      get 'post_relation'
      get 'favorite'
      get 'vote'
    end
  end

  match 'signout' => 'sessions#destroy'
end
