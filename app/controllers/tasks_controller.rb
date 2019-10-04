class TasksController < ApplicationController
 
 # This collects the instances of Task
 def index 
  @tasks = Task.all
 end
 
 # This method preps the URL extension by task ID number to show the desired task
 def show
  task_id = params[:id].to_i
  @task = Task.find_by(id: task_id)
  if @task.nil?
   redirect_to root_path
  end
 end
 
 def new
  @task = Task.new
 end
 
 def create
  @task = Task.new( name: params[:task][:name], description: params[:task][:description], progress: params[:task][:progress], completion_date: params[:task][:completion_date])
  
  # @task.completion_date.to_date
  
  if @task.save
   redirect_to task_path(@task.id)
  else
   render new_task_path
  end
 end
 
end
