Rails.application.routes.draw do

  get 'gestione_feedback/show'
  #get 'sessions/new'
  root 'home#index'


  get 'gestione_account', to: 'gestione_account#manage'
  get 'statistiche', to: 'statistiche#show'
  get 'gestione_feedback', to: 'gestione_feedback#show'
  get 'signup', to: 'acquirentes#new', as: 'signup'
  get 'admin_signup', to: 'amministratores#new', as: 'admin_signup'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'


  get 'lista_desideri', to: 'lista_desideri#index'
  post 'add_to_wishlist/:id', to: 'lista_desideri#add', as: 'add_to_wishlist'
  delete 'remove_from_wishlist/:id', to: 'lista_desideri#remove', as: 'remove_from_wishlist'

  get 'archivio ordini', to: 'archivio_ordini#index', as: 'archivio_ordini'
  get 'cronologioricerche', to: 'cronologia_ricerche#index', as: 'cronologia_ricerche'
  
  get 'messaggi', to: 'messaggi#index', as: 'messaggi'

#  get 'profile', to: 'users#profile', as: 'profile'

#  get 'home/index'

  resources :resi, only: [:index, :update]


  resources :categorias, only: [:show]

  resources :prodottos
  resources :recensiones
  resources :variantis
  resources :negozios, only: [:new, :create, :show] do
    resources :prodottos, only: [:new, :create]
    member do
      get 'visualizza', to: 'negozios#visualizza'
    end
  end
  resources :acquirentes, only: [:new, :create, :show,  :edit, :update]
  resources :amministratores, only: [:create, :show, :edit, :update]
  
  resources :faqs do
    collection do
      get 'admin'
    end
  end
  


  resources :messaggi, only: [:index, :show, :destroy] do
    member do
      get 'rispondi'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
