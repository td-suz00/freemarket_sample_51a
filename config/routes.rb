Rails.application.routes.draw do
 get  'items/new'  =>  'items#new'
 get  'cards/index'  =>  'cards#index'
 get  'cards/new'  =>  'cards#new'

  root 'items#index'

  resources :users, only: [:show]

end
