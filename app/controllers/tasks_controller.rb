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
  
  # def new
  # end
  
  # def create
  # end
  
  # def edit
  # end
  
  # def update
  # end
  
  # def delete
  # end
end
