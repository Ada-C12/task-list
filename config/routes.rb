Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # verb 'path', to: 'controller#action'
 
 # Routes that operate on all tasks
  root 'tasks#index'

  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task'

   # Routes that operate on individual tasks
  get '/tasks/:id', to: 'tasks#show', as: 'task'


   # # Routes that operate on all books
  # get '/books', to: 'books#index', as: 'books'
  # get '/books/new', to: 'books#new', as: 'new_book'
  # post '/books', to: 'books#create'

  # # Routes that operate on individual books
  # get '/books/:id', to: 'books#show', as: 'book'
  # get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  # patch '/books/:id', to: 'books#update'
  # delete '/books/:id', to: 'books#destroy'
end
