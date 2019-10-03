class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      # head :not_found
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    form = params["task"]
    @new_task = Task.new

    @new_task.name = form["name"]
    @new_task.description = form["description"]
    # form_date = "#{form["due_date(2i)"]}/#{form["due_date(3i)"]}/#{form["due_date(1i)"]}"
    # new_task.due_date = DateTime.parse(Date.parse(form_date).strftime("%Y/%-d/%-m"))

    @new_task.completed = nil
    @new_task.status = "INCOMPLETE"
    
    if @new_task.save
      redirect_to task_path( @new_task.id )
    else

    end
  end
end
