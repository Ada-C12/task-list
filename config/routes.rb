Rails.application.routes.draw do
  root to: 'tasks#index'
  
  # tasks_path calls TaskCtrler.index() and user GETs to see /tasks
  get '/tasks', to: 'tasks#index', as: 'tasks'
  
  ### I think normall resources :tasks will take care of all the routes for me...?
  # new_task_path calls TasksCtrler.new() and user GETs to see /tasks/new
  get '/tasks/new', to: 'tasks#new', as: 'new_task' 
  # after user fills out form in /tasks/new, it gets POSTed via TasksCtrler.create(), 
  # which may GET user diff pages depending on results (redirect? 404? render b/c bad info?)
  post '/tasks', to: 'tasks#create'
  # its' weird why POST '/tasks/new' will give error, am I supposed to think of it as POSTING to the entire /tasks directory? idk
  # also, why no prefix for this line? b/c '/tasks' was already named as tasks_path on line 5, u can't add an alternate name either!
  
  # task_path calls TasksCtrler.show(id: ???) and user GETs to see /tasks/:id
  get '/tasks/:id', to: 'tasks#show', as: 'task'
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


