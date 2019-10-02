class TasksController < ApplicationController
  
  def index 
    @tasks = Task.all
  end
  
  def show 
    task_name = params[:name]
    @task = Task.find_by(name: task_name)
    
    if @task.nil?
      head:not_found
      return 
    end 
  end
  
  def new
    @task = Task.new
  end
  
end
