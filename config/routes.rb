Rails.application.routes.draw do
 get   'items/new'  =>  'items#new'

  root 'items#index'

  resources :users, only: [:show]

end
