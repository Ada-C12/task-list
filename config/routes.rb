Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "tasks#index"
  get "/tasks", to: "tasks#index"
  get "/:task", to: "tasks#show"
end
