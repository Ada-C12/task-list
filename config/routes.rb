Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks
  # get "/tasks", to: "tasks#index", as: "tasks"
  # post "/tasks", to: "tasks#create"
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # get "/tasks/:id", to: "tasks#show", as: "task"
  # patch "/tasks/:id", to: "tasks#update"
  # delete "/tasks/:id", to: "tasks#destroy"
  # get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"

  patch "/tasks/:id/complete", to: "tasks#toggle_complete", as: "complete_task"
  patch "/tasks/:id/incomplete", to: "tasks#toggle_incomplete", as: "incomplete_task"
end
