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
 
 #new and create methods work in congress. New makes a new instance. Create actually uses the information from the filled in form to then save the instance into the db. 
 def new
  @task = Task.new
 end
 
 def create
  @task = Task.new(task_params)
  
  if @task.save
   redirect_to task_path(@task.id)
  else
   render new_task_path
  end
 end
 
 #dit and update methods work in congress. Edit gets the information that's going to changed. Update actually uses the informxation from the filled in form to then update the instance information in the db. 
 def edit
  begin
   @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
   redirect_to root_path
  else @task = Task.find(params[:id])
  end
 end
 
 def update
  @task = Task.find_by(id: params[:id])
  @task.name = params[:task][:name]
  @task.description = params[:task][:description]
  @task.progress = params[:task][:progress]
  @task.completion_date = params[:task][:completion_date]
  
  if @task.save(id: params[task.id])
   redirect_to task_path(@task.id)
  else
   redirect_to action: 'index', status: 303
  end
 end
 
 def destroy
  @task = Task.find_by(id:params[:id])
  if @desired_task.nil?
   redirect_to root_path
  else
   @task = Task.find_by(id:params[:id])
   @task.destroy
   redirect_to root_path
  end
 end
 
 
 private
 
 def task_params
  return params.require(:task).permit(:name, :description, :progress, :completion_date)
 end
 
end
