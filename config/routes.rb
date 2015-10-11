Rails.application.routes.draw do
  resources :gps_files do
    member do
      get 'import'
      get 'export'
    end
  end

  resources :gps_files

  devise_for :users, :path => 'u'

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
