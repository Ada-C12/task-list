class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
    
  end
  
  def show
    task = params[:id]
    @task = Task.find_by(id: task)
    if @task.nil?
      head :redirect
      return
    end
  end
  
  
  
end
