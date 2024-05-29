Rails.application.routes.draw do
  resources :recensiones
  resources :variantis
  resources :prodottos
  resources :negozios
  resources :acquirentes
  resources :amministratores
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
