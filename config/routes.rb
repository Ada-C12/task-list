Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'

  root :to => "tasks#index"

  get '/tasks', to: 'tasks#index'

  get '/tasks/:id', to: 'tasks#show'
end
end
