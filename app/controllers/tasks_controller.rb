class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path
      return
    end 
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path
      return
    end 
    
    @task.update(name: params[:task][:name], description: params[:task][:description])
    
    redirect_to task_path(@task)
    
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      head :not_found
      return
    end 
    
    @task.destroy
    redirect_to tasks_path
  end
  
end
