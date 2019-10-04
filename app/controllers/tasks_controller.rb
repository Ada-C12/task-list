
#TASKS = [ "Cleaning", "Grocery", "Cooking", "Laundry" ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

# create a controller action
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
  
    if @task.nil?
      redirect_to new_task_path
      return
    end
  end
  #Create a new task
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)  #instantiate a new task using strong params
    if @task.save 
      #redirect_to task_path(@task.id)
      redirect_to root_path 
      return
    else 
      render :new
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path 
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    # In the line above, Task.find_by is coming back as nil...
    if @task.nil?
      redirect_to root_path 
      return
    end

    if @task.update(task_params)
      redirect_to root_path 
      return
    else 
      redirect_to root_path 
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy

    redirect_to tasks_path
    return
  end

  private
    def task_params 
      return params.require(:task).permit(:name, :description, :date)
    end

end