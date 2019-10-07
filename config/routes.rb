Rails.application.routes.draw do
  
  root 'tasks#index'
  resources :tasks 
  
  patch '/tasks/:id/completed', to: 'tasks#completed', as: 'completed'
end
