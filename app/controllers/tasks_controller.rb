TASKS = [
    {to_do: "Do homework"},
    {to_do: "Clean house"},
    {to_do: "Cook dinner"},
    {to_do: "Sleep"},
    {to_do: "Come to class tomorrow"},
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
