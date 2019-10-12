class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
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
    @task = Task.new( task_params )
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id] )
    if @task.nil?
      redirect_to tasks_path
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id] )
    
    if @task.nil?
      redirect_to root_path
    elsif @task.update( task_params )
      redirect_to task_path(@task.id)
    else
      render edit_task_path
    end
  end
  
  def destroy
    
    target_task = Task.find_by( id: params[:id] )
    
    if target_task.nil?
      redirect_to root_path
      return
    else
      target_task.destroy
      redirect_to root_path
      return
    end
  end
  
  def toggle
    @task = Task.find_by( id:params[:id])
    
    if @task.nil?
      redirect_to root_path
    elsif @task.completed == nil
      @task.update(completed: Time.now)
      redirect_to root_path
    elsif @task.completed != nil
      @task.update(completed: nil)
      redirect_to root_path
    end
  end
  
  private 
  def task_params
    
    return params.require(:task).permit(:name, :description, :completed)
    
  end
end

