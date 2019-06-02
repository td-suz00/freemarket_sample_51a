Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  root 'items#index'

  resources :items, only: :new
  resources :users, only: [:new, :show] do
    resources :cards, only: [:index, :new, :edit, :show]
    resources :user_profiles, only: [:new, :edit]
    resources :logouts, only: :new
    resources :signups, only: [:index, :new, :show]
  end
end