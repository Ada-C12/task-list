class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completion_date: params[:task][:completion_date]
    )
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else 
      render :new 
      return
    end
  end
  
  # def edit
  #   @task = Task.find_by(id: params[:id])
  #   if @task.nil?
  
  #   end
  # end
end

