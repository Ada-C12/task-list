Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "tasks#index"
  
  # verb 'path', to: 'controller#action'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
end
