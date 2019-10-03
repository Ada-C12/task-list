class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to root_path, flash: { error: "Could not find task with id: #{task_id}" }
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    # instantiate a new Task based on form input
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    
    # if the task can be saved to the database,
    if @task.save
      # go to that task's page
      redirect_to task_path(@task.id)
      return
    else
      # otherwise, show the new task form again
      render :new
    end
  end
  
end
