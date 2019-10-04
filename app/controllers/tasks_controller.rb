class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:id)
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id:task_id)
    if @task.nil?
      redirect_to tasks_path
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
      render new_task_path
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
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render new_task_path
      return
    end
  end
  
  def destroy
    choosen_task = Task.find_by(id: params[:id])
    if choosen_task.nil?
      redirect_to tasks_path
      return
    else
      choosen_task.destroy
      redirect_to root_path
      return
    end
  end
  
  def completed
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to task_path
      return
    end
    if @task.completed == nil
      @task.completed = Date.today
      @task.save
      redirect_to root_path
    else
      @task.completed = nil
      @task.save
    redirect_to root_path
    end

    # @task.update_attribute(:completed, Time.now)
    # if @task.nil?
    #   redirect_to root_path
    #   return
    # if @task.completed?
    #   @task.toggle!(:completed)
    #   @task.completed.save = Time.now
    #   redirect_to root_path
    #   return
    # else
    #   @task.completed = nil
    #   redirect_to root_path
    # end
    
  end
end
