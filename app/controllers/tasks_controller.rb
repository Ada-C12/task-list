class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to root_path
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
      return
    else
      render :new
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    else 
      # strong params
      if @task.update(task_params)
        redirect_to task_path(@task.id)
        return
      else
        render :new
        return
      end
    end
  end
  
  # def destroy
  #   task = Task.find_by(id: params[:id])
  
  #   if task.nil?
  #     redirect_to tasks_path
  #     return
  #   else
  #     task.destroy
  #     redirect_to root_path
  #     return
  #   end
  # end
  
  # def mark_completed
  # end
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
