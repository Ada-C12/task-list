class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
  end

  def new
    @task = Task.new
  end

  def create
    form_data = params["task"]
    name = form_data["name"]
    description = form_data["description"]

    @task = Task.new(name: name, description: description)
  end
end
