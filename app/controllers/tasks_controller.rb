class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      # head :not_found
      redirect_to tasks_path
      return
    end
  end 

  def new
    # no attributes listed with the instance, so rails assume that you want to add/create something.
    # basically, it knows that you want to make a post request
    @task = Task.new
  end 

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
    if @task.completed.nil?
      redirect_to tasks_path
      return
    elsif @task.save
      redirect_to task_path(@task.id)
      return
    end 
  end 

  # def edit
  #   @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed]) #instantiate a new task
  #   if @task.save # save returns true if the database insert succeeds
  #     redirect_to '/tasks' # go to the index so we can see the book in the list
  #     return
  #   else # save failed :(
  #     render :new # show the new book form view again
  #     return
  #   end
  # end 

end
