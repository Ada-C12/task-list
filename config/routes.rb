# config/routes.rb
Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get '/tasks/status/:id', to: 'tasks#toggle_complete', as: 'task_status'
end
