Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :records, only: %i[index create]
end
