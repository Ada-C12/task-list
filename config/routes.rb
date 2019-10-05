Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  patch 'tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  resources :tasks
end
