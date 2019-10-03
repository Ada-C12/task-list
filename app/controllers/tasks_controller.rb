class TasksController < ApplicationController
  def index
    @tasks = Task.order(:id)
  end
  
  def show
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path 
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
      return
    end
  end
  
  # def edit
  # end
  
  # def update
  # end
  
  # def delete
  # end
end
