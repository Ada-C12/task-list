Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # verb 'path', to: 'controller#action'
    get '/tasks', to: 'tasks#index'
    get "/tasks/:id", to: 'tasks#show'
    root 'tasks#index'
end

# https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/08-rails/restful-routing.md
# Verb	URI Pattern	Controller#Action	Description
# GET	/books	books#index	List of all books
# GET	/books/new	books#new	Form to add a new book
# POST	/books	books#create	Send form data to the server and save a new book
# GET	/books/:id	books#show	Show details for one book
# GET	/books/:id/edit	books#edit	Form to edit details for an existing book
# PATCH	/books/:id	books#update	Send form data to the server to update an existing book
# DELETE	/books/:id	books#destroy	Destroy an existing book