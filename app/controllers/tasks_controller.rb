class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:task].to_i
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
  
  end 
end
