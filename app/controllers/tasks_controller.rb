class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
    @task.name = "A very important task"
    @task.description = "Very important details"
  end
  
  def create
    @task = Task.new(task_params)
    
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
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render edit_task_path
      return
    end
  end

  def destroy
    selected_task = Task.find_by(id: params[:id])

    if selected_task.nil?
      redirect_to tasks_path
      return
    else
      selected_task.destroy
      redirect_to tasks_path
      return
    end
  end

  def toggle_complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.completed.nil?
      @task.update(completed: Time.now)
      redirect_to task_path(@task.id)
      return
    elsif @task.completed
      @task.update(completed: nil)
      redirect_to task_path(@task.id)
      return
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
end
