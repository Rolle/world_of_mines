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
      get 'update_group'
    end
  end
  resources :users

  resources :mines do
    collection do
      get "map"
      get "locked"
      get "own"
      get "search"
      get  "work_list"
      get "delete_work_list"
      get "export_work_list"
      get "export_all"
      get "sort_work_list"
      get "state_work_list"
      get "clear_work_list"
      get "add_page_list_items"
      get "add_current_list_items"
      get "last_edited"
      get "created"
    end
    member do
      post "updateajax"
      get  "createajax"
      get  "add_or_remove_list_item"
      post  "lock"
    end
  end
  
  resources :mines

  resources :events do
    collection do
      get "clear"
    end
  end
  resources :events
  
  resources :photos do
    collection do
      get "own"
    end
  end
  resources :photos
  
  root 'mines#map'
  
end
