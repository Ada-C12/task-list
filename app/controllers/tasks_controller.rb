class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      #redirect_to tasks_path
      head :not_found
      return
    end

  end

  def new

    # creates a new empty form
    # this is empty, because in #create, user will fill in info on the form

    @task = Task.new
  end

  def create
    # we can access the form data from the new task form using params and its very specific data structure

    # *********HOW DO YOU SEE THIS PARAMS STRUCTURE???***************
    @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])

    if @task.save
      redirect_to task_path(@task.id)
    else
      
      render new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completion_date = params[:task][:completion_date]

    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

end
