Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  root 'home#index'

  get '/auth/google_oauth2', to: 'auth#google', as: :google_auth
  get '/auth/google_oauth2/callback', to: 'auth#callback'
  get '/auth/failure', to: 'auth#failure'

  get 'profilo/seguiti', to: 'acquirentes#seguiti', as: :acquirente_seguiti
  get 'follows/create'
  get 'follows/destroy'
  get 'feedbacks/new'
  get 'feedbacks/create'
  get 'return_requests/index'
  get 'return_requests/new'
  get 'return_requests/create'
  get 'return_requests/show'
  get 'return_requests/update'

  get 'ordini_negozi/index'
  get 'ordini_negozi/show'
  get 'ordini_negozi/update'

  get 'gestione_feedback/show'
  get 'gestione_account', to: 'gestione_account#manage'
  get 'statistiche', to: 'statistiche#show'
  get 'signup', to: 'acquirentes#new', as: 'signup'
  get 'admin_signup', to: 'amministratores#new', as: 'admin_signup'

  get 'amministratore/statistiche', to: 'amministratores#statistiche', as: :statistiche_amministratore


  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'lista_desideri', to: 'lista_desideri#index'
  post 'add_to_wishlist/:id', to: 'lista_desideri#add', as: 'add_to_wishlist'
  delete 'remove_from_wishlist/:id', to: 'lista_desideri#remove', as: 'remove_from_wishlist'

  get 'archivio ordini', to: 'archivio_ordini#index', as: 'archivio_ordini'
  get 'cronologiaricerche', to: 'cronologia_ricerche#index', as: 'cronologia_ricerche'

  resources :resi, only: [:index, :update]

  resources :negozios do
    resources :ordini, controller: 'ordini_negozi', only: [:index, :show, :update]
    post 'follow', to: 'follows#create'
    delete 'unfollow', to: 'follows#destroy'
    resources :prodottos, only: [:new, :create]
    member do
      get :statistiche
      get 'recensioni', to: 'recensioninegozio#index'
      get 'feedbacks', to: 'negozios#feedbacks'
      get 'visualizza', to: 'negozios#visualizza'
      get 'seguaci'
    end
  end

  resources :prodotti do
    resources :statistiche, only: [:index, :show]
  end

  resources :promoziones do
    collection do
      get 'admin'
      get 'negozio'
    end
  end

  resources :categorias, only: [:show]
  resources :prodottos
  resources :recensiones
  resources :variantis
  resources :acquirentes do
    member do
      get 'visualizza'
    end
  end
  
  resources :amministratores, only: [:create, :show, :edit, :update]

  resources :faqs do
    collection do
      get 'admin'
    end
  end

  resources :chat_rooms, only: [:index, :show, :new, :create] do
    post 'messages', to: 'chat_rooms#create_message', as: :messages
    post :start, on: :collection
    post :assistenza, on: :collection
  end

  resource :carrello, only: :show
  resources :carrello_items, only: [:create, :destroy]

  resources :ordini, only: [:new, :create, :show, :index] do
    collection do
      get 'successo', to: 'ordini#successo'
      get 'errore', to: 'ordini#errore'
    end
    post :pagamento, on: :member
    resources :return_requests, only: [:new, :create]
  end

  resources :return_requests, only: [:index, :show, :new, :create, :update]

  resources :negozio_return_requests, only: [:show, :index, :create] do
    member do
      patch :approve
      patch :reject
    end
  end

  resources :gestione_account, only: [:index] do
    member do
      patch :blocca
      patch :sblocca
      delete :elimina
    end
  end

  resources :feedbacks do
    member do
      patch :segnala
      patch :ignora_segnalazione
    end
  end

  resources :password_resets, only: [:new, :create, :edit, :update]


  get 'admin/feedbacks_segnalati', to: 'amministratores#feedbacks_segnalati', as: 'admin_feedbacks_segnalati'

  # Monta Action Cable
  mount ActionCable.server => '/cable'
end
