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
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: nil) 
    if @task.save 
      redirect_to tasks_path 
      return
    else 
      render :new
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to tasks_path 
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to root_path
      return
    end
    
    if @task.update(name: params[:task][:name], description: params[:task][:description]) 
      redirect_to task_path 
      return
    else 
      render :new
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to root_path
      return
    end
    
    if @task.destroy
      redirect_to tasks_path
      return
    else
      render :new
      return
    end
  end
  
  def toggle_complete
    @task = Task.find_by(id: params[:id])
    if @task.completion_date.nil?
      @task.completion_date = Date.today
      @task.save
      redirect_to tasks_path
      return
    else
      @task.completion_date = nil
      @task.save
      redirect_to tasks_path
      return
    end
  end
  
  
end
