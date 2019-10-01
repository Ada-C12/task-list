TASKS = [
    {task: "Do homework"},
    {task: "Relax little"},
    {task: "Come to class tomorrow"},
  ]
class TasksController < ApplicationController
    def index
        @tasks = TASKS
        # @task = {}
    
    end

    def show
        @tasks = TASKS
        task_id = params[:id].to_i
        @task = @tasks[task_id]
    end

end
