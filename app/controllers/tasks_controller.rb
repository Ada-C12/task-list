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
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date] )
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  def complete
    params[:task_ids].each do |id|
      @task = Task.find_by(id: id.to_i )
      @task.completion_date = Time.now
    end
    
    if @task.save
      redirect_to tasks_path
    else
      render tasks_path
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id] )
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  def destroy
    task = Task.find_by( id: params[:id] )
    
    if task.nil?
      redirect_to tasks_path
      return
    else
      task.destroy
      redirect_to root_path
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id] )
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
end