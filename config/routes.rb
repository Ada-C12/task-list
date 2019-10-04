Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'tasks#index'
  resources :tasks, except: [:update]
  patch '/tasks/:id', to: 'tasks#update', as: 'update_task'
  
  
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete'
  patch '/tasks/:id/toggle_incomplete', to: 'tasks#toggle_incomplete', as: 'toggle_incomplete'
  
  
  
  
end
