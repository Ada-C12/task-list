Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  put '/tasks/:id/complete', to: 'tasks#toggle_complete', as: 'toggle_complete'
end
