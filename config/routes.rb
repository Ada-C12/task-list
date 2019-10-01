Rails.application.routes.draw do
  root "tasks#index"
  get "/tasks", to: "tasks#index"
  post "/tasks", to: "tasks#create"
  get "/tasks/new", to: "tasks#new", as: "new_task"
  get "/tasks/:id", to: "tasks#show", as: "task"
end
