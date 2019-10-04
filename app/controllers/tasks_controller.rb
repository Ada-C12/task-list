class TasksController < ApplicationController
 
 # This collects the instances of Task
 def index 
  @tasks = Task.all
 end
 
 # This method preps the URL extension by task ID number to show the desired task
 def show
  task_id = params[:id].to_i
  @task = Task.find_by(id: task_id)
  # if @task.nil?
  #  head :not_found
  #  return
  # end
 end
 
 def new
  @task = Task.new
 end
 
 def create
  @task = Task.new( name: params[:task][:name], description: params[:task][:description], progress: params[:task][:progress], completion_date: params[:task][:completion_date])
  @task.progress = "not started"
  @task.completion_date = "N/A"
  
  
  
  @task.save
 end
 
end
