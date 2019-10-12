Rails.application.routes.draw do
  root to: 'tasks#index'
  
  resources :tasks
  patch '/tasks', to: 'tasks#toggle', as: 'toggle'
  
  ### REFACTORED OUT via RESOURCES ####
  # # tasks_path calls TaskCtrler.index() and user GETs to see /tasks
  # get '/tasks', to: 'tasks#index', as: 'tasks'
  
  # ### I think normall resources :tasks will take care of all the routes for me...?
  # # new_task_path calls TasksCtrler.new() and user GETs to see /tasks/new
  # get '/tasks/new', to: 'tasks#new', as: 'new_task' 
  # # after user fills out form in /tasks/new, it gets POSTed via TasksCtrler.create(), 
  # # which may GET user diff pages depending on results (redirect? 404? render b/c bad info?)
  # post '/tasks', to: 'tasks#create'
  # # POST '/tasks/new' will give error. Think: after being done with /tasks/new, u want to POST back up to /tasks
  # # also, why no prefix for this line? b/c '/tasks' was already named as tasks_path on line 5, u can't add an alternate name either!
  
  # # task_path calls TasksCtrler.show(:id) and user GETs to see /tasks/:id
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  
  # # edit_task_path calls TasksCtrler.edit(:id) and user GETs to see /tasks/:id/edit.html
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # # after form.submission on /tasks/:id/edit, PATCH calls TasksCtrler.update(:id) and will send user to diff pgs depending on ctrler code
  # patch '/tasks/:id', to: 'tasks#update'
  # # PATCH '/tasks/:id/edit' will give error too.  Think: after being done with /tasks/:id/edit, u want to PATCH back up to /tasks/:id
  ### end REFACTORED OUT via RESOURCES ####
  
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


