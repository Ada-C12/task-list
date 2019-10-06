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
    @task.name = "A very important task"
    @task.description = "Very important details"
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render new_task_path
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
    elsif @task.update(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
      redirect_to task_path(@task.id)
      return
    else
      render edit_task_path
      return
    end
  end
end
