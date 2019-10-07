# TASKS = [
#   "brush my teeth", "take my B12 vitamin drops", "laundry"
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
    puts @tasks
  end
  
  def show
    task_id = params[:id]
    
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new( task_params )
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render new_task_path
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

    if @task.update( task_params )
      redirect_to task_path(@task.id)
      return
    else
      render edit_task_path(@task.id)
      return
    end
    
  end
  
  def destroy
    the_correct_task = Task.find_by( id:params[:id] )
    if the_correct_task.nil?
      redirect_to tasks_path
      return
    else
      the_correct_task.destroy
      redirect_to root_path
    end
  end
  
  def completed_task
    @task = Task.find_by( id:params[:id] )
    if @task.completion_date == nil
      @task.completion_date = DateTime.now
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

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
  
end
