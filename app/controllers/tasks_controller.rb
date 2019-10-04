class TasksController < ApplicationController
  
  def index
    @tasks = Task.all 
  end
  
  def new
    # ROUTES SAYS: get '/tasks/new', to: 'tasks#new', as: 'new_task' 
    @task = Task.new
    # @task.completion_date = nil
  end
  # .new() GETs user to /tasks/new, form.submit there POSTs to .create()
  def create
    # This is AFTER user submits form to make new Task
    @task = Task.new(params_from_form)
    @msg = nil
    
    # validate parameters
    if @task.name == ""
      @msg = "You must name your task"
      render new_task_path
      return
    end
    
    # ready to save
    if @task.save
      redirect_to task_path(@task.id)
    else
      @msg = "for some reason Task.save() failed"
      render new_task_path(@task)
    end
    
  end
  
  def show
    # input may be from user manually typing in URL
    # input may be from another Ctrler#action sending us down task_path(id), which involves triggering .show()
    input = params[:id]
    if input.to_i.to_s == input
      # if input is a valid integer
      @task = Task.find_by(id: params[:id])
      unless @task
        # if id# doesn't exist
        redirect_to root_path
      end
    else 
      # if input is not an integer
      head :not_found
      return
    end
  end
  
  private
  def params_from_form
    return params.require(:task).permit(:name, :description, :completion_date)
  end
  
end
