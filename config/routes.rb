Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index', as: 'root'
  get '/tasks/:name', to: 'tasks#show'
end
