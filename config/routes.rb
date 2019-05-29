Rails.application.routes.draw do
 get  'items/new'  =>  'items#new'
 get  'cards/index'  =>  'cards#index'
 get  'cards/new'  =>  'cards#new'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy" 
  end

  root 'items#index'  
  get   'items/new'  =>  'items#new'

  resources :users, only: [:show]

end
