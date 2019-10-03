class TasksController < ApplicationController
  before_action :find_by_task, only: [:show, :edit, :update, :destroy, :toggle_complete, :toggle_incomplete]

  def index
    @tasks = Task.all
  end

  def show
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
      redirect_to @task
    else
      render "new"
      return
    end
  end

  def edit
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    if @task.nil?
      redirect_to tasks_path
    else
      @task.update(task_params)
      redirect_to task_path(@task.id)
    end
  end

  def destroy
    if @task.nil?
      head :not_found
    else
      @task.destroy
      redirect_to tasks_path
    end
  end

  def toggle_complete
    if @task.nil?
      redirect_to tasks_path
    else
      @task.completion_date = DateTime.current
      @task.save
      redirect_to tasks_path
    end
  end

  def toggle_incomplete
    if @task.nil?
      redirect_to tasks_path
    else
      @task.completion_date = nil
      @task.save
      redirect_to tasks_path
    end
  end

  private

  def find_by_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
