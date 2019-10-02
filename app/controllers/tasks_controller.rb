class TasksController < ApplicationController
  
  def index
    @greeting = "HELLO, THERE!"
    @tasks = Task.all
  end
  
  def show
    @tasks = Task.all
    task_id = params[:id].to_i
    @task = @tasks.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: " + task_id.to_s
      redirect_to root_path
      return
    end
  end
  
end
