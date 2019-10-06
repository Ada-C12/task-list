require "time"

class TasksController < ApplicationController
  
  def index 
    @tasks = Task.all 
  end 

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to task_path
      return
    end
  end

  def new
    @task = Task.new
  end 

  def create
    @task = Task.new(task_strong_params)

    if @task.save
      redirect_to task_path(@task.id)
      return
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
    elsif @task.update(task_strong_params)
      redirect_to task_path(@task.id)
      return
    else
      render new_task_path
    end
  end

  def destroy
    selected_task = Task.find_by(id: params[:id])

    if selected_task.nil?
      redirect_to root_path
      return
    else
      selected_task.destroy
      redirect_to root_path
      return
    end
  end

  def completed 
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    else
      if @task.completed == nil 
        @task.completed = Time.now
        @task.save
        redirect_to root_path
        return
      end
    end
  end 

  private
  def task_strong_params
    return params.require(:task).permit(:name, :description, :completed)
  end 
end
