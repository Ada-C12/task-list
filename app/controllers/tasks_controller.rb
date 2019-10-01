class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
    
  end
  
  def show
    task = params[:id].to_i
    @task = Task.find_by(id: task)
    if @task.nil?
      head :not_found
      return
    end
  end
  
  
  
end
