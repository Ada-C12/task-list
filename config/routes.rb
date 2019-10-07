  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # config/routes.rb
Rails.application.routes.draw do
  # verb 'path', to: 'controller#action'

  root :to => "tasks#index"
  
  resources :tasks

  patch '/tasks/:id/mark_complete', to: 'tasks#mark_complete', as: 'mark_complete'

end