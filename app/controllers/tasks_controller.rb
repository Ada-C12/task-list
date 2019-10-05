#TASKS = ["Laundry", "Feed Babette", "Clean room", "Sleep"] 
class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
    if @task.save
      redirect_to task_path(@task.id)
    else
      redirect_to root_path
    end
  end 
  
  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: params[:id] )
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if !@task.nil?
      @task.update(task_params)
      redirect_to task_path(@task.id)
    else
      redirect_to root_path
    end
  end
  
  def destroy
    the_correct_task = Task.find_by( id: params[:id] )
    
    if the_correct_task.nil?
      redirect_to tasks_path
      return
    else
      the_correct_task.destroy
      redirect_to root_path
      return
    end
  end
  
  
  
  
  
  
  private
  # The responsibility of this method is to return "strong params"
  # .require is used when we use form_with and a model, and therefore our expected form data has the "book" hash inside of it
  # .permit takes in a list of names of attributes to allow... (aka the new Book form has title, author, description)
  # Remember: If you ever update the database, model, and form, this will also need to be updated
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
end