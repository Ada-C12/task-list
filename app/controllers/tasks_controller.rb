class TasksController < ApplicationController
  
  def index
    @tasks = Task.all 
  end
  
  def show
    user_input = params[:id]
    if user_input.to_i.to_s == user_input
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
  
  def new
    # User wants to make a new Task, so we'll need to send user to empty form
    @task = Task.new
    # @task.completion_date = "Pending"
  end
  
  def create
    # This is AFTER user submits form to make new Task
    @task = Task.new(params_from_form)
    @error_msg = ""
    
    # validate parameters
    invalid_form = false
    if @task.name == ""
      @error_msg = "You must name your task"
      # elsif @task.completion_date 
      #parse the comp date soemhow
    else
      if @task.save
        redirect_to task_path(@task.id)
      else
        render tasks_new_path(@task)
      end
    end
  end
  
  
  private
  def params_from_form
    return params.require(:task).permit(:name, :description, :completion_date)
  end
  
end
