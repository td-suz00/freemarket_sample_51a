Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get 'items/search_category' , to: 'items#search_category'
  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  root 'top#index'

  resources :purchases, only: :new
  resources :items, only: [:new, :create, :edit, :update]
  resources :users, only: :show do
    resources :cards, only: [:index, :new]
    resources :user_profiles, only: [:new, :create, :edit, :update]
    resources :user_confirmations, only: [:create, :edit, :update]
    resources :logouts, only: :new
  end

end
