class TasksController < ApplicationController
  def index
    @tasks = Task.order(:name)
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
  
  def create
    # @task = Task.new(
    #   name: params[:task][:name], 
    #   description: params[:task][:description], 
    #   completed: params[:task][:completed]
    # )
    
    @task = Task.new(task_params)
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else 
      render :new 
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(task_params)
      # name: params[:task][:name],
      # description: params[:task][:description],
      # completed: params[:task][:completed]
      
      redirect_to task_path(@task.id)
      return
    else 
      render :edit
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.destroy
      redirect_to tasks_path
      return
    else
      render :show
    end
  end
  
  def make_completed
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    else
      @task.update(completed: DateTime.now)
      redirect_to tasks_path
      return
    end
  end
  
  def make_not_completed
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    else
      @task.update(completed: nil)
      redirect_to tasks_path
      return
    end
  end
end

# if want to add a check box for "read", for example
# need to add to _form.html.erb, add :read in database
# and add :read in permitted tasks parameters