Rails.application.routes.draw do
  root to: 'notes#index'

  concern :unarchivable do
    post 'unarchive', on: :member
  end

  resources :notes, concerns: :unarchivable do
    get 'preview', on: :collection
  end

  resources :contacts, concerns: :unarchivable
end
