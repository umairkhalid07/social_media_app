Rails.application.routes.draw do
  resources :friends

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show]

  resources :friend_requests do
    collection do
      get :create_friend_request
    end
  end

  root 'posts#index'
end
