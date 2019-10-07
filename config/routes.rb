Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => 'tasks#index', as: 'root'
  
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  
  patch '/tasks/:id', to: 'tasks#update'
  
  get '/tasks/:id/completing', to: 'tasks#completing', as: 'completing'
  
  patch '/tasks/:id/completing', to: 'tasks#mark_as_completed', as: 'completed'
  
  # patch '/tasks/:id', to: 'tasks#mark_as_completed', as: 'mark_as_completed'
  
  resources :tasks
  
end
