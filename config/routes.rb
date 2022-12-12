Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :friends
  resources :users do
    resources :conversations
  end
  resources :posts do
    resources :reactions do
      collection do
        get :like
        get :dislike
      end
    end
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :friend_requests do
    collection do
      get :create_friend_request
      get :accept_friend_request
    end
  end
end