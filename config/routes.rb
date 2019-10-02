Rails.application.routes.draw do
  root :to => "tasks#index"
  get "/tasks", to: "tasks#index", as: "tasks"
  get "/tasks/new", to: "tasks#new", as: "new_task"
  get "tasks/:id", to: "tasks#show "
  # get "/tasks/:name", to: "tasks#show"
  post "/tasks", to: "tasks#create"
  patch "/tasks/:id", to: "tasks#update"
  get "/tasks/:id/edit", to: "tasks#edit"
  delete "/books/:id", to: "books#destroy"
end
