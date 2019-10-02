class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
    
  end
  
  def show
    task = params[:id]
    @task = Task.find_by(id: task)
    if @task.nil?
      head :not_found
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date]) 
    if @task.save 
      redirect_to tasks_path 
      return
    else 
      render :new
      return
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  
end
