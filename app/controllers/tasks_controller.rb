class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
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
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id)
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to task_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completed: params[:task][:completed]
    )
      redirect_to tasks_path
      return
    else 
      render :edit 
      return
    end
  end
end