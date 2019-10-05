Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "tasks#index"
  get "/tasks", to: "tasks#index", as: "tasks"
  get "/tasks/new", to: "tasks#new", as: "new_task"
  get "tasks/:task/edit", to: "tasks#edit", as: "edit_task"
  get "tasks/:task", to: "tasks#show", as: "task"
  post "/tasks", to: "tasks#create"
  patch "/tasks/:id", to: "tasks#update"
  delete "/tasks/:id", to: "tasks#destroy"


  
end
