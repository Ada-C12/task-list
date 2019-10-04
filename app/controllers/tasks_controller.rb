class TasksController < ApplicationController
  # TASKS = [
  #   { name: " Watch CS Videos", description: "Watch Video Chris POsted", completed: "10/03/19" },
  #   { name: "Rails Tasks Project", description: "Do all waves of tasks", completed: "10/07/19" },
  #   { name: "POODR Reading", description: "Read POODR", completed: "10/05/19" },
  # ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to new_task_path
    end
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if !@task
      redirect_to edit_task_path
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if !@task
      redirect_to edit_task_path
      return
    end
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completed = params[:task][:description]

    if new_task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

  def destroy
    task_to_delete = Task.find_by(id: params[:id])
    if task_to_delete.nil?
      redirect_to tasks_path
      return
    else
      task_to_delete.destroy
      redirect_to root_path
      return
    end
  end
end
