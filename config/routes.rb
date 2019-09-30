
# config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'
  get '/tasks', to: 'tasks#index'
end
