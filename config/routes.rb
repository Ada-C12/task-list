Rails.application.routes.draw do
  root :to => 'tasks#index'

  resources :tasks
  # will neeed a marked complete route
end
