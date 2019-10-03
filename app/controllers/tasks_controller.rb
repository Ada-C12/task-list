class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
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
      return
    else
      render :new
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.update(
      name: params[:task][:name],
      description: params[:task][:description]
      )
      redirect_to tasks_path
    return
    else
      render :edit
    end

  end

end
