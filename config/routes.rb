Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'

  get 'friends#new', to: 'friends#create'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show]

  # resources :friend_requests

  resources :friend_requests do
    collection do
      get :create_friend_request
    end
  end

  root 'posts#index'
end
