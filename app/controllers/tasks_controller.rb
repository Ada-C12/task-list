class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path, :flash => { :error => "Could not find task with id: #{task_id}" }
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
end
