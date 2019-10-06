# TASKS = [
#   {title: "emails", description: "write some overdue replies", completion_date: Time.now + 1.days},
#   {title: "plan road trip", description: "decide where you're going and plan snacks", completion_date: Time.now + 3.days},
#   {title: "make soup", description: "shop for ingredients and make some soup", completion_date: Time.now + 5.days}
# ]

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
    @task = Task.new(task_params) 
    @task.completed = nil
    if @task.save 
      redirect_to task_path(@task) 
      return
    else
      render :new 
      return
    end
  end
  
  def edit 
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path
      return 
    end 
  end
  
  def update
    @task = Task.find_by(id: params[:id]) 
    if @task.nil?
      redirect_to root_path
      return 
    end
    if params[:task][:completed] == "1"
      update_completed = Time.now 
    else 
      update_completed = nil
    end 
    if @task.update(task_params)
      @task.completed = update_completed
      redirect_to tasks_path
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
      redirect_to root_path
      return
    end 
    
    @task.destroy 
    redirect_to root_path
    return 
  end 
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end 
  
end
