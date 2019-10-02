

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id:task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    task_params = params[:task]
    task = Task.new(name: task_params[:name], description: task_params[:description])
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
      redirect_to tasks_path
      return
    end
    
    task_params = params[:task]
    task.name = task_params[:name]
    task.description = task_params[:description]
    task.save
    
    redirect_to task_path(task)
  end
  
end
