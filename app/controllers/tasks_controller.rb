
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

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
    # don't need to explicitly set completion_date to nil; will be nil if left blank
    if @task.save
      redirect_to task_path(@task)
      return
    else
      render :new
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to edit_task_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
    result = @task.update(task_params)
    if result
      redirect_to task_path(@task.id) # or params[:id]
    else
      render :edit
      return
    end
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    if task.nil?
      head not:not_found
      return
    end

    if task.destroy
      redirect_to tasks_path
      return
    end
  end

  def toggle_complete
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to edit_task_path
      return
    end
    if @task.completion_date == nil
      @task.update(completion_date: Date.today)
    elsif @task.completion_date != nil
      @task.update(completion_date: nil)
    end
    if @task.save
      redirect_to tasks_path
      return
    end
  end


  private
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end

end
