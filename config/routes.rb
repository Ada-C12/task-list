Rails.application.routes.draw do
  resources :tasks
  root :to => "tasks#index"

  put 'completed_task', to: 'tasks#completed', as: 'completed_tasks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
