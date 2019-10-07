Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "tasks#index"

  get '/tasks/all', to: 'tasks#all', as: 'all_tasks'
  get '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
  get '/tasks/:id/uncomplete', to: 'tasks#uncomplete', as: 'uncomplete_task'
  resources :tasks
end
