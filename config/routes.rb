Rails.application.routes.draw do
  resources :gps_files do
    member do
      get 'import'
      get 'export'
    end
  end

  resources :gps_files

  devise_for :users, :path => 'u'

  resources :users do
    member do
      get 'switch_admin'
      get 'switch_superadmin'
    end
  end

  resources :users

  resources :mines do
    collection do
      get "map"
      post "search"
    end
    member do
      post "updateajax"
    end
  end
  
  resources :mines
  resources :events
  resources :photos
  
  root 'mines#map'
  
end
