Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  # delete '/tasks/:id', to: 'tasks#delete', as :delete_task
  # resources :tasks, except: [:destroy]
end
