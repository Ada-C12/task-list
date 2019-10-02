class TasksController < ApplicationController
  # TASKS = [
  #   { name: " Watch CS Videos", description: "Watch Video Chris POsted", due: "10/03/19" },
  #   { name: "Rails Tasks Project", description: "Do all waves of tasks", due: "10/07/19" },
  #   { name: "POODR Reading", description: "Read POODR", due: "10/05/19" },
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
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], due: params[:task][:due])
    if new_task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

  def new
    @task = Task.new
  end
end
