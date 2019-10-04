Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "tasks#index"
  
  get '/tasks', to: 'tasks#index'
  get '/books/new', to: 'books#new'
  get '/tasks/:id', to: 'tasks#show'
  
end