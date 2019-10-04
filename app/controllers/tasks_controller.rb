class TasksController < ApplicationController
  
  def index
    @greeting = "HELLO, THERE!"
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: " + task_id.to_s
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
    @task.completion_date = Date.today + 5
  end
  
  def create
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date] )
    
    @task.save
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  def edit
    task_id = params[:id].to_i
    @edit_task = Task.find_by(id: task_id)
    
    if @edit_task.nil?
      redirect_to tasks_path
      return
    end    
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
    # params_to_update = {
    #   name: params[:task][:name], 
    #   description: params[:task][:description], 
    #   completion_date: params[:task][:description]
    # }
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completion_date = params[:task][:completion_date]
    
    @task.save
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render new_task_path
    end
    
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
    
    @task.destroy
    
    if @task.destroy
      redirect_to root_path
    else
      return
    end
    
  end
  
  
  
  def complete 
    
    @task = Task.find_by(id: params[:id])
    
    if @task.completion_date.nil?
      @task.completion_date = Date.today
    else
      @task.completion_date = nil
    end
    
    @task.save
    
    redirect_to root_path
    
  end
  
  
end
