
#TASKS = [ "Cleaning", "Grocery", "Cooking", "Laundry" ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
# create a controller action
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
  
    if @task.nil?
      redirect_to new_task_path
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
      head :not_found
      return
    end
  end
  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(
      name: params[:task][:name], 
      description: params[:task][:description],
      date: params[:task][:date]
    )
      redirect_to books_path 
    else 
      render :edit 
      return
    end
  end
end