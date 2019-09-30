Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index', as: 'root'
end
