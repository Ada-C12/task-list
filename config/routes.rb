Rails.application.routes.draw do

  root :to => "tasks#index"
  
  resources :tasks
  patch '/tasks/:id/completed', to: 'tasks#completed', as: 'completed_task'

end
