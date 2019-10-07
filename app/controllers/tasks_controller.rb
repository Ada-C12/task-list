class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      # head :not_found
      return
    end
  end

  def new
    # creates a new empty form
    # this is empty, because in #create, user will fill in info on the form
    @task = Task.new
  end

  def create

    # we can access the form data from the new task form using params and its very specific data structure

    # will not set params for completion_date, by leaving it blank, it'll default to nil

    @task = Task.new( name: params[:task][:name], description: params[:task][:description])

    if @task.save
      redirect_to task_path(@task.id)
    else
      
      render new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
    end

  end

  def update
    if @task = Task.find_by(id: params[:id])

      @task.name = params[:task][:name]
      @task.description = params[:task][:description]
      @task.save
      redirect_to task_path(@task.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    correct_task = Task.find_by(id: params[:id])

    if correct_task.nil?
      redirect_to tasks_path
      return
    else 
      correct_task.destroy
      redirect_to root_path
      return
    end
  end

  def mark_complete
    @completed_task = Task.find_by(id: params[:id])

    # if the task doesn't exist, redirect to root
    if @completed_task.nil?
      redirect_to root_path
      return
    end

    # if completion_date is nil, assign Time.now
    # else, convert completion_date to nil to mark it incomplete 
    if @completed_task.completion_date == nil
      @completed_task.completion_date = Time.now
      @completed_task.save
      redirect_to root_path
      return
    else
      @completed_task.completion_date = nil
      @completed_task.save
      redirect_to root_path
      return
    end
  end

end
