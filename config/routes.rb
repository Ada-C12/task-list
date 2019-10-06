Rails.application.routes.draw do
  root 'tasks#index'
  
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  resources :tasks
end
