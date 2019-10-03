class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
    
  end
  
  def show
    task = params[:id]
    @task = Task.find_by(id: task)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task}"
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
      redirect_to tasks_path 
      return
    else 
      render :new
      return
    end
  end
  
  def edit
    task = params[:id]
    @task = Task.find_by(id: task)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task}"
      redirect_to tasks_path 
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date]) 
      redirect_to tasks_path 
      return
    else 
      render :new
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.destroy || @task.nil?
      redirect_to tasks_path
      return
    else
      render :new
      return
    end
  end
  
  
end
