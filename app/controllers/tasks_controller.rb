class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  # show the task by the id number
  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      flash[:error] = "Could not find task with id: -1"
      redirect_to tasks_path
      return
    end
  end
  
  # generate a new task
  def new
    @task = Task.new
  end
  
  # submit and save the new task
  def create
    @task = Task.new(create_task_params)
    
    if @task.save
      redirect_to @task
      return
    else
      render :new
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task
      # Do something
      if @task.update_attributes(update_task_params)
        redirect_to task_path(@task)
        flash[:success] = "Your task has successfully been updated." 
      else 
        flash[:error] = "Uh Oh! Something went wrong."
        render :edit
      end
    else 
      redirect_to tasks_path
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Are you sure you want to delete?"
    redirect_to tasks_path
    return
  end
  
  def complete
    task = Task.find_by(id: params[:id])
    
    if task.update_attribute(:completed_at, Time.now)
      flash[:success] = "Your task has successfully been marked as completed." 
    else
      flash[:error] = "Uh Oh! Something went wrong."
    end
    
    redirect_to task_path(task)
  end
  
  private
  
  def create_task_params
    params.require(:task).permit(:name, :description)
  end
  
  def update_task_params
    params.require(:task).permit(:name, :description)
  end
end
