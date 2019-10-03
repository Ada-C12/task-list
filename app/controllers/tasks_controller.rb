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
    form_data = params["task"]
    name = form_data["name"]
    description = form_data["description"]
    completion_date = form_data["completion_date"]

    @task = Task.new(name: name, description: description, completion_date: completion_date)

    if @task.save
      redirect_to @task
    else
      render "new"
      return
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    task_id = params[:id]
    form_data = params["task"]
    name = form_data["name"]
    description = form_data["description"]

    task_id = params[:id]
    task_to_update = Task.find_by(id: task_id)

    if task_to_update.nil?
      redirect_to tasks_path
    else
      task_to_update.update(name: name, description: description)
      redirect_to task_path(task_to_update.id)
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      head :not_found
      return
    end

    @task.destroy
    redirect_to tasks_path
  end

  private

  def find_by_task
  end

  def task_params
    return params.require(:task).permit(:name, :description)
  end
end
