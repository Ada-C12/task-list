Rails.application.routes.draw do
  root 'tasks#index'
  # verb 'path', to: 'controller#action'
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
end