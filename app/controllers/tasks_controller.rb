class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  # show the task by the id number
  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      
      # return
      flash[:error] = "Could not find task with id: -1"
      redirect_to tasks_path #:flash => { :notice => "Could not find task with id: -1" } 
    end
  end
  
  # generate a new task
  def new
    @task = Task.new
  end
  
  # submit and save the new task
  def create
    @task = Task.new(task_params)
    
    if @task.save
      # DELETE COMMENT ONCE INSTRUCTOR PROVIDES CLARIFICATION
      # redirect_to tasks_path
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
    end
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update(name: params[:task][:name], description: params[:task][:description])
    redirect_to task_path(@task)
  end
  
  def destroy
    
  end
  
  
  
  private
  
  def task_params
    params.require(:task).permit(:id, :name, :description, :completed_at)
  end
end
