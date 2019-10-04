class TasksController < ApplicationController
  
  def index 
    @tasks = Task.all 
  end 

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to task_path
      return
    end
  end

  def new
    @task = Task.new
  end 

  def create
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completed: nil)

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
    if @task.nil?
      redirect_to root_path
      return
    else 
      @task = Task.find_by(id: params[:id])
      @task.name = params[:task][:name]
      @task.description = params[:task][:description]
      @task.completed = params[:task][:completed]
    end
  end
end
