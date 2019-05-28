Rails.application.routes.draw do
 get   'items/new'  =>  'items#new'
#  resources :items, only: [:new]
end
