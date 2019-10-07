class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end 

  def new
    # no attributes listed with the instance, so rails assumes that you want to add/create something.
    # basically, it knows that you want to make a post request
    @task = Task.new
  end 

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])

    if @task.name == " "
      redirect_to tasks_path
      return
    elsif  @task.save
      redirect_to task_path(@task.id)
      return
    end 
  end 

  def edit
    # this is an instance variable so the view can access it
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to task_path 
      return
    end 

    if @task.update(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completed: params[:task][:completed]
    )
      redirect_to task_path 
      return
    else # save failed :(
      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    else 
      @task.destroy

      redirect_to tasks_path
      return 
    end 
  end

  def complete
    # Update the database with the task's completed date
    task_id = params[:id]

    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return

    elsif @task.completed == nil
      @task.completed = Time.now
      @task.save
      redirect_to tasks_path
      return 

    elsif @task.completed != nil
      @task.completed = nil
      @task.save
      redirect_to tasks_path
      return
    end 
  end 
end
