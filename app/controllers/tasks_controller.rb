class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:task].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: nil)
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

  def edit
    # task_id = params[:id]
    @task = Task.find_by(id: params[:task])
    if @task.nil?
      redirect_to edit_task_path
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

  def destroy
    found_task = Task.find_by(id: params[:id])
    if found_task.nil?
      redirect_to root_path 
      return 
    else 
      found_task.destroy 
      redirect_to root_path 
      return 
    end 
  end

end
