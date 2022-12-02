Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :friends
  resources :users do
    resources :posts
  end

  resources :friend_requests do
    collection do
      get :create_friend_request
      get :accept_friend_request
    end
  end
end
