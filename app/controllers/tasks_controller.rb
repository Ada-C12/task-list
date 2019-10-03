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
    task_id = params[:task].to_i
    @task = Task.find_by(id: task_id)
    if @tasks.nil?
      return head :not_found
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
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.name = params[:book][:name]
    @task.description = params[:book][:description]
    @task.completed = params[:book][:description]

    if new_task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
end
