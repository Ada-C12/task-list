class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
    end
  end
  
  def new
    @task = Task.new
    
  end
  
  def create
    @task = Task.new(task_params)
    @task.completed = nil
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    @task.update( task_params )
    redirect_to tasks_path
  end
  
  def complete
    complete_task = Task.find_by(id: params[:id])
    Time.zone = "Pacific Time (US & Canada)"
    complete_task.completed = DateTime.now.in_time_zone
    complete_task.save
    redirect_to tasks_path
  end
  
  def uncomplete
    uncomplete_task = Task.find_by(id: params[:id])
    uncomplete_task.completed = nil
    uncomplete_task.save
    redirect_to tasks_path
  end
  
  def destroy
    the_correct_task = Task.find_by(id: params[:id])
    if the_correct_task.nil?
      redirect_to tasks_path
      return
    else
      the_correct_task.destroy
      redirect_to root_path
      return
    end
  end
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
  
end
