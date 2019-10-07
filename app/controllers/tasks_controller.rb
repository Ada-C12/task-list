class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def all
    @tasks = Task.all
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
    redirect_to tasks_path
    return
  end

  
  @task.name = params[:task][:name]
  @task.description = params[:task][:description]
  
  if @task.save
    redirect_to task_path(@task.id)
    return
  else
    render new_task_path
    return
  end
end

def destroy
  destroy_task = Task.find_by(id: params[:id])

  if destroy_task.nil?
    redirect_to tasks_path
    return
  else
    destroy_task.destroy
    redirect_to tasks_path
    return
  end
end


def complete
  @task = Task.find_by(id: params[:id])
  if @task.nil?
    redirect_to tasks_path
    return
  end

  if @task.completed == nil
    current_time = Time.current
    @task.update(completed: current_time)
  end
  
  if @task.save
    redirect_to tasks_path
    return
  else
    render new_task_path
    return
  end
end


def uncomplete
  @task = Task.find_by(id: params[:id])
  if @task.nil?
    redirect_to tasks_path
    return
  end

  if @task.completed != nil
    @task.update(completed: nil)
  else
    raise StandardError.new("trying to uncomplete an uncompleted task")
  end
  
  if @task.save
    redirect_to tasks_path
    return
  else
    render new_task_path
    return
  end
end



private
def task_params
  return params.require(:task).permit(:name, :description)
end

end
