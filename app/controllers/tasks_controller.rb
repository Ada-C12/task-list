class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params) 
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
      redirect_to root_path
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
    
    if @task.update(task_params)
      redirect_to task_path (@task.id)
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
    
    @task.destroy
    
    redirect_to tasks_path
    return 
  end
  
  def complete
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
    
    if @task.completion_date == nil
      @task.completion_date = Time.now
    else
      @task.completion_date = nil
    end
    
    unless @task.save 
      redirect_to tasks_path
    end
    
    redirect_to tasks_path
    return 
  end
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
  
end
