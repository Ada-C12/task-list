Rails.application.routes.draw do
  root to: "tasks#index"
  patch "/tasks/:id/complete", to: "tasks#complete", as: "complete_task"
  patch "/tasks/:id/not_complete", to: "tasks#not_complete", as: "not_complete_task"
  resources :tasks, except: [:update]
  patch "/tasks/:id", to: "tasks#update"
end
