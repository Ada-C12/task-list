Rails.application.routes.draw do
  root :to => "books#index"
  get '/tasks', to: 'tasks#index'
end