class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        task_id_raw = params[:id]
        task_id = task_id_raw.to_i
        @task = Task.all[task_id]
        if task_id.to_s != task_id_raw || !@task
            head :not_found
            return
        end
    end
end
