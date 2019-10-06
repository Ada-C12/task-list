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
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
      return
    else
      render :new
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if@task.nil?
      head :not_found
      return
    end
  end 

  def update
    @task = Taks.find_by(id: params[:id])
    if @task.update(task_params)
      redirect_to root_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy

    redirect_to root_path
    return
  end

  private

  def task_params
    return params.require(:task).permit(
      :name, 
      :description, 
      :completed)
  end

end
