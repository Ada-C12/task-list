class TasksController < ApplicationController
  def index
    @tasks = Task.all 
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to root_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      head :not_found
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path 
      return
    end
    
    if @task.update(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completed: params[:task][:completed])
      redirect_to root_path  
      return
    else  
      render :edit  
      return
    end
  end
  
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      head :not_found
      return
    end
    
    @task.destroy
    
    redirect_to root_path
    return
  end
  
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
  
  def toggle_complete 
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      head :not_found
      return
    end
    
    if @task.completed == nil
      @task.update(completed: Time.now)
      redirect_to tasks_path
      return 
    else
      @task.update(completed: nil)
      redirect_to tasks_path
      return
    end 
  end 
end


# make button on page

