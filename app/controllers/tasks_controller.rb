
class TasksController < ApplicationController
    def index
        @tasks = Task.all
        # @task = {}
    
    end

    def show
        task_id = params[:id].to_i
        @task = Task.find(task_id)
        
    end

end
