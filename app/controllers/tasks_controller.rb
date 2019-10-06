
class TasksController < ApplicationController
  include TasksHelper
  
  def index
    @tasks = Task.all
  end
  
  def new
    # ROUTES SAYS: get '/tasks/new', to: 'tasks#new', as: 'new_task' 
    @task = Task.new
  end
  ### FROM ABOVE ###
  # .new() GETs user to /tasks/new, form.submit there POSTs to .create()
  ### TO DOWN BELOW ###
  def create
    # This is AFTER user submits form to make new Task
    @task = Task.new(params_from_form)
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      # .save failed Model's validation 
      render action: 'new' 
      return
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
        return
      end
    else 
      # if input is not an integer
      head :not_found
      return
    end
  end
  
  def edit
    # ROUTES says:   get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
    # first, get the task item user wants, from params which is either from manual URL or from other links
    @task = Task.find_by(id: params[:id])
    unless @task
      redirect_to root_path
      return
    end
  end
  ### FROM ABOVE ###
  # .edit() GETs user to /tasks/:id/edit, form.submit there PATCHes to .update()
  ### TO DOWN BELOW ###
  def update
    # get the correct task database item
    id = params[:id].to_i
    @task = Task.find_by(id: id)
    
    if @task.nil?
      # id doesn't exist
      redirect_to root_path
      return
    end
    
    if @task.update(params_from_form)
      # success
      redirect_to task_path(id: @task.id)
      return
    else
      # failed validation from Models (if any), or something wrong with other params
      render action: 'edit', params: { id: @task.id }
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    @task.destroy if @task
    
    # whether @task existed or not, it doesn't now
    redirect_to root_path
    return
  end
  
  def toggle
    @task = Task.find_by(id: params[:id])
    
    if @task
      if @task.completion_status == nil
        now = Time.now
        
        # IF I WRITE OUT THE STRING HERE, AND STORE IT AS STRING, IT'S OK
        today_str = display_date(now)
        
        @task.update(completion_status: true, completion_datetime: now, display_date: today_str)
      else
        @task.update(completion_status: nil)
      end
      redirect_to root_path
      return
    else
      # user shouldn't be able to click a toggle button to a task that doesn't exist
      head :not_found
      return
    end
  end
  
  def display_date(time_obj)
    # HELPER FCN: Takes the Time obj, and returs a string that says "yyyy-mm-dd", like "2019-10-5"
    yyyy = time_obj.year.to_s
    mm = time_obj.month.to_s
    dd = time_obj.day.to_s
    date_str = yyyy + "-" + mm + "-" + dd
    return date_str
  end
  
  private
  def params_from_form
    return params.require(:task).permit(:name, :description, :completion_status)
  end
  
end