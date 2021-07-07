Rails.application.routes.draw do
  root "tasks#index"

  patch "/tasks/:id/complete", to: "tasks#toggle_complete", as: "complete_task"
  patch "/tasks/:id/incomplete", to: "tasks#toggle_incomplete", as: "incomplete_task"

  resources :tasks
end
