Rails.application.routes.draw do

  #get 'sessions/new'
  root 'home#index'

  get 'gestione_account', to: 'gestione_account#manage'
  get 'statistiche', to: 'statistiche#show'

  get 'signup', to: 'acquirentes#new', as: 'signup'
  get 'admin_signup', to: 'amministratores#new', as: 'admin_signup'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'


  get 'lista_desideri', to: 'lista_desideri#index'
  get 'archivio ordini', to: 'archivio_ordini#index', as: 'archivio_ordini'
  get 'cronologioricerche', to: 'cronologia_ricerche#index', as: 'cronologia_ricerche'
  get 'faq', to: 'faq#index', as: 'faq'
  get 'messaggi', to: 'messaggi#index', as: 'messaggi'



#  get 'profile', to: 'users#profile', as: 'profile'

#  get 'home/index'
  resources :prodottos, only: [ :show]
  resources :recensiones
  resources :variantis
  resources :negozios, only: [:new, :create, :show] do
    resources :prodottos, only: [:new, :create]
  end
  resources :acquirentes, only: [:new, :create, :show]
  resources :amministratores, only: [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
