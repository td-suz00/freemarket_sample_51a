Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get 'items/search_category' , to: 'items#search_category'
    get 'items/auto_complete' , to: 'items#auto_complete'
  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  root 'top#index'

  resources :items, only: [:new, :create, :edit, :update] do
    resources :purchases, only: :new do
      collection do
        post 'pay', to: 'purchases#pay'
      end
    end
  end

  resources :users, only: [:new, :show] do
    resources :cards, only: [:index, :new, :show, :destroy] do
      collection do
        get 'add', to: 'cards#add'
        post 'pay', to: 'cards#pay'
      end
    end
    #### :showは仮置き。signup#doneなどのアクションにあてるのが良いか
    resources :user_profiles, only: [:new, :create, :edit, :update]
    resources :user_confirmations, only: [:create, :edit, :update]
    resources :logouts, only: :new
    resources :signups, only: [:index, :new, :show]
  end

end