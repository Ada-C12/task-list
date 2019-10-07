

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    task = Task.new(task_params)
    task.save
    
    redirect_to tasks_path
  end
  
  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id:task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end
  end
  
  def update
    task_id = params[:id].to_i
    task = Task.find_by(id:task_id)
    if task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to root_path
      return
    end
    
    task_params = params[:task]
    task.name = task_params[:name]
    task.description = task_params[:description]
    task.save
    
    redirect_to task_path(task)
  end
  
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      flash[:error] = "Error, could not delete task."
      redirect_to root_path
      return
    end
    @task.destroy
    redirect_to root_path
  end
  
  def toggle_complete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      flash[:error] = "Error, task not found."
      redirect_to root_path
      return
    end
    
    @task.completed = Time.new
    @task.save
    redirect_to root_path
  end
  
  def toggle_incomplete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      flash[:error] = "Error, task not found."
      redirect_to root_path
      return
    end
    
    @task.completed = nil
    @task.save
    redirect_to root_path
  end
  
  private
  def task_params
    return params.require(:task).permit(:name, :description, :id)
  end
  
end