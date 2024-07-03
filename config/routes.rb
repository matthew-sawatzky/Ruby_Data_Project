Rails.application.routes.draw do
  root "books#index"
  
  get 'about', to: 'static_pages#about'
  
  resources :books, only: [:index, :show]
  resources :authors, only: [:index, :show]
  resources :publishers, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :reports, only: [:index]
end
