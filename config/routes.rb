Rails.application.routes.draw do
  
  get 'organisations/index'

  get 'organisations/show'

  get 'organisations/new'

  get 'organisations/create'

  get 'organisations/edit'

  get 'organisations/update'

  get 'organisations/destroy'

  get 'organisations/join'

  put 'organisations/join'

  post 'organisations/join'

  post 'organisations/leave'

  get 'shift/index'

  get 'shift/show'

  get 'shift/new'

  post 'shift/create'

  patch 'shift/edit'

  patch 'shift/update'

  get 'shift/update'

  get 'shift/destroy'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  post 'users/create'

  patch 'users/edit'

  patch 'users/update'

  get 'users/update'

  get 'users/destroy'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  resources :users  
  resources :organisations  
  resources :shifts 
  resources :sessions   

  root 'sessions#new'  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
