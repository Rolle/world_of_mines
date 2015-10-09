Rails.application.routes.draw do

  devise_for :users

  resources :users

  resources :mines do
    collection do
      get "map"
    end
    member do
      post "updateajax"
    end
  end
  
  resources :mines
  
  root 'mines#map'
  
end
