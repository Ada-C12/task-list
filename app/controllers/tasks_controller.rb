class TasksController < ApplicationController
  
  def index
    @tasks = Task.all.order(:id)
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
    @task = Task.new(task_params)
    
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
    
    if @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render edit_task_path(@task.id)
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
    
    @task.destroy
    redirect_to tasks_path
    return
  end
  
  def toggle
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
    
    if @task.completion_date == nil
      @task.completion_date = DateTime.now
    else
      @task.completion_date = nil
    end
    
    @task.save
    redirect_to tasks_path
    return
  end
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
  
end