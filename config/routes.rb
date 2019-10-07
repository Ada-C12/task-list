Rails.application.routes.draw do
    root to: 'tasks#index'
    resources :tasks
    put '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
end
