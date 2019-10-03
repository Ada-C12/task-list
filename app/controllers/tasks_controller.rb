#TASKS = ["Laundry", "Feed Babette", "Clean room", "Sleep"] 
class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
    if @task.save
      redirect_to root_path
    else
      redirect_to new_task_path
    end
  end 
end

