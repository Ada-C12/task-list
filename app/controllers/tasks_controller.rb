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
    @task = Task.new(name: params[:task][:name], description: params[:task][:description]) 
    if @task.save 
      redirect_to task_path(@task.id)
      return
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
    elsif @task.update(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
      redirect_to tasks_path
      return 
    else 
      render :edit
      return
    end
  end 
  
  def completed 
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      head :not_found
      return
    end
    
    @task.completion_date = Time.now
    @task.save 
    
    return
  end
  
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      head :not_found
      return
    end
    
    @task.destroy
    
    redirect_to tasks_path
    return
  end
end