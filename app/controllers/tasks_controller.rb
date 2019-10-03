class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task_id = params[:id]
    @task = Task.find_by(id: @task_id)

    if @task.nil?
      head :not_found
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], due: params[:task][:due])
    if @task.save
      redirect_to tasks_path
      return
    else
      render :new
      return
    end
  end
end
