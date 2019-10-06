Rails.application.routes.draw do
  root :to => 'tasks#index'

  resources :tasks
  
  patch '/tasks/:id/completed', to: 'tasks#toggle_complete', as: :toggle_complete
end
