class TasksController < ApplicationController
  
  def index
    @greeting = "HELLO, THERE!"
    @tasks = Task.all
  end
  
  def show
    @tasks = Task.all
    @task_id = params[:id].to_i
    # @spookymode = false
    @task = @tasks.find_by(id: @task_id)
    if @task.nil?
      head :not_found
      return
    end
  end
  
end
