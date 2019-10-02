class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    # puts "In show!!!"
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      # puts "In @task.nil?"
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    completion_date = Time.parse("#{params[:task][:completion_date]}")
    
    @task = Task.new(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completion_date: completion_date
    )
    if @task.save
      redirect_to tasks_path 
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

