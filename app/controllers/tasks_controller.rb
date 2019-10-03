
#TASKS = [ "Cleaning", "Grocery", "Cooking", "Laundry" ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
# create a controller action
  def show
    task_id = params[:id]
    @task = Task.find(task_id)
  
    if @task.nil?
      head :not_found
      return
    end
  end
  #Create a new task
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], date: params[:task][:date]) #instantiate a new book
    if @task.save 
      redirect_to tasks_path 
      return
    else 
      render :new 
      return
    end
  end
end
