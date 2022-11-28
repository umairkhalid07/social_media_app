Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show]
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'posts#index'
end
