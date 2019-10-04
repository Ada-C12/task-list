Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  
  put '/tasks/:id/', to: 'tasks#complete', as: 'complete_task'
end