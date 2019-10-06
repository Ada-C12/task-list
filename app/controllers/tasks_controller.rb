require 'time'

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
    @task = Task.new(task_params)

    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task == nil
      redirect_to tasks_path
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task == nil
      redirect_to tasks_path
      return
    end

    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completion_date = params[:task][:completion_date]

    if @task.save
      redirect_to task_path(@task.id)
    end
  end

  def destroy
    the_correct_task = Task.find_by( id: params[:id] )

    if the_correct_task.nil?
      # Then the task was not found!
      redirect_to tasks_path
      return
    else
      # Then we did find it!
      the_correct_task.destroy
      redirect_to root_path
      return
    end
  end

  def toggle_complete
    @task = Task.find_by(id: params[:id])
    if @task.completion_date == nil
      #changes the completion status to Time.now
      @task.completion_date = Time.now
    else
      #changes the completion status back to nil
      @task.completion_date = nil
    end

    if @task.save
      redirect_to tasks_path
    end
  end

  private

  def task_params
    #the responsibility of this method is to return strong params
    #.require is used when we use form_with a model, and therefore our expected form data has the "task" hash inside of it
    #.permit takes in a list of names of attributes to allow... tasks have name, description, completion_date
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
