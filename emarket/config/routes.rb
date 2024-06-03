Rails.application.routes.draw do
  #get 'sessions/new'
  root 'home#index'

  get 'signup', to: 'acquirentes#new', as: 'signup'
  get 'admin_signup', to: 'amministratores#new', as: 'admin_signup'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'profile', to: 'users#profile', as: 'profile'

#  get 'home/index'
  resources :prodottos, only: [:index, :show]
  resources :recensiones
  resources :variantis
  resources :prodottos
  resources :negozios
  resources :acquirentes, only: [:create]
  resources :amministratores, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
