Rails.application.routes.draw do
  root 'tasks#index'
  
  #add a /markcomplete path or something
  patch '/tasks/:id/', to: 'tasks#complete', as: 'complete_task'
  resources :tasks
  
end