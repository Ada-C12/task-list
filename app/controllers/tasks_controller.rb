class TasksController < ApplicationController
  
  def index
    @greeting = "HELLO, THERE!"
    @tasks = Task.all
  end
  
  def show
    @tasks = Task.all
    task_id = params[:id].to_i
    @task = @tasks.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: " + task_id.to_s
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
    @task.completion_date = Date.today + 5
  end
  
  def create
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date] )
    
    @task.save
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  
end
