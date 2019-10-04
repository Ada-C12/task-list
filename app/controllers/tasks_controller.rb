class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path, :flash => { :error => "Could not find task with id: #{task_id}" }
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: nil)
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
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
    end
    
    if @task.update(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
    
    @task.destroy
    redirect_to root_path
  end
  
  def mark_complete
    @task = Task.find_by(id: params[:id])
    
    if @task.completion_date.nil?
      @task.update(completion_date: Time.now)
      redirect_to task_path(@task.id)
      return
    else
      @task.update(completion_date: nil)
      redirect_to task_path(@task.id)
      return
    end
  end
end
