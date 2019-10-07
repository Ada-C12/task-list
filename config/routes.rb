Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  
  resources :tasks, except: [:update]
  patch 'tasks/:id', to: 'tasks#update'
  patch 'tasks/:id/completion', to: 'tasks#toggle_complete', as: 'completed'
end

