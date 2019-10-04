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
    @task.completion_date = nil
  end
  
  def create
    @task = Task.new( task_params )
    
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
    
    @task.update( task_params )
    
    if @task.update( task_params )
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
  
  
  private
  
  def task_params
    
    return params.require(:task).permit(:name, :description, :completion_date)
    
  end
  
end
