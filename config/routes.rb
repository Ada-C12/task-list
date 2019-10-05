Rails.application.routes.draw do
  root :to => 'tasks#index'

  resources :tasks
  # will neeed a marked complete route
  patch '/tasks/:id/completed', to: 'tasks#mark_completed', as: :mark_complete
  
end
