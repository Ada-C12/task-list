Rails.application.routes.draw do
  root :to => "tasks#index"
  # resources :tasks, except: [:edit]
  get "/tasks", to: "tasks#index", as: "tasks"
  get "/tasks/new", to: "tasks#new", as: "new_task"
  post "/tasks", to: "tasks#create"
  get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  get "tasks/:id", to: "tasks#show", as: "task"
  # get "/:name", to: "tasks#show"
  patch "/tasks/:id", to: "tasks#update", as: "update_task"

  delete "/tasks/:id", to: "tasks#destroy"
end
