class TasksController < ApplicationController
  def index
    @task = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      head :not_found
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
      return
    else
      render :new
      return
    end  
  end
  
  def edit
    @task = Task.find(params[:id])
    
    if @task == nil?
      redirect_to root_path
    end
  end
  
  def update
    @task = Task.update(task_params)
    redirect_to root_path
  end
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    @task.delete
    redirect_to root_path
  end
end

private

def task_params
  return params.require(:task).permit(:name, :title, :description, :completed)
end
