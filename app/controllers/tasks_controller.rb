
class TasksController < ApplicationController
  include TasksHelper
  
  def index
    @tasks = Task.all.order(:id)
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
    @tasks = [@task]
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
    task = Task.find_by(id: params[:id])
    task.destroy if task
    
    # whether task existed or not, it's gone now
    redirect_to root_path
    return
  end
  
  def toggle
    @task = Task.find_by(id: params[:id])
    
    if @task
      if @task.completion_datetime
        @task.completion_datetime = nil
      else
        now = Time.now
        @task.completion_datetime = now
      end
      
      if @task.save
        db_task = Task.find_by(id: @task.id)
        
        if params[:destination] == "root"
          redirect_to root_path
          return
        elsif params[:destination] == "show"
          redirect_to task_path(id: @task.id)
          return
        else
          # impossible, user can only trigger #toggle via a link from root or show
          head :not_found
          return
        end
      else
        # probably failed a validation in Model, go investigate!
        head :not_found
        return
      end
      
      
    else
      # user shouldn't be able to click a toggle button to a task that doesn't exist
      head :not_found
      return
    end
  end
  
  private
  def params_from_form
    return params.require(:task).permit(:name, :description, :completion_datetime)
  end
  
end