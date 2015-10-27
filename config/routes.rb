Rails.application.routes.draw do

  resources :notes
  resources :user_notes

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
      get "locked"
      get "own"
      post "search"
    end
    member do
      post "updateajax"
      get  "createajax"
      post  "lock"
      post "unlock"
    end
  end
  
  resources :mines

  resources :events do
    collection do
      get "clear"
    end
  end
  resources :events
  resources :photos
  
  root 'mines#map'
  
end
