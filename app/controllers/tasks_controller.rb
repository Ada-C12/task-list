class TasksController < ApplicationController
  
  def index 
    @tasks = Task.all
  end
  
  def show 
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      # head:not_found
      return 
    end 
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(completion_date: params[:task][:completion_date], name: params[:task][:name], description: params[:task][:description]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id)
      return
    else # save failed :(
      render :new # show the new book form view again
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
    
    if @task.update(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
      redirect_to tasks_path
      return 
    else 
      render :edit
      return
    end
  end 
end