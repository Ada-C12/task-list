class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.completion_date = nil
    @task.complete = false
    
    if @task.save
      redirect_to task_path(@task)
      return
    else
      render :new
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
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
    
    @task.update(task_params)
    
    redirect_to task_path(@task)
    return
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      head :not_found
      return
    end 
    
    @task.destroy
    redirect_to tasks_path
    return
  end
  
  def toggle_complete
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path
      return
    end 
    
    if @task.complete
      @task.update(complete: false, completion_date: nil)
    else
      @task.update(complete: true, completion_date: Time.now)
    end
    
    redirect_to task_path(@task)
    return
  end
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description)
  end
end
