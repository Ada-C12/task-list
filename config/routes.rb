Rails.application.routes.draw do
  root to: "tasks#index"
  
  resources :tasks
  patch "tasks/:id/complete", to: "tasks#toggle", as: "complete"
end