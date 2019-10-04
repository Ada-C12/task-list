class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
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
    
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completion_date = params[:task][:completion_date]
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render edit_task_path(@task.id)
      return
    end
  end
  
end