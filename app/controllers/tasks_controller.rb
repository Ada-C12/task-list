class TasksController < ApplicationController
  
  def index
    @greeting = "HELLO, THERE!"
  end
  
  def show
    @task_id = params[:id].to_i
    @spookymode = false
    @tasks = ["task", "task2", "task3"]
    @task = @tasks[@task_id]
    if @task.nil?
      head :not_found
      return
    end
  end
  
end
