Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/tasks', to: 'tasks#index', as: 'root_path'

  root 'tasks#index'
  resources :tasks 
  patch 'tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
end


