class TasksController < ApplicationController
  def index
    @tasks = Task.all.sort_by{ |h | h[:id] }
  end

  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return 
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: nil) #instantiate a new book
    if @task.name != ""
      @task.save
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
    elsif @task.update(
      name: params[:task][:name], 
      description: params[:task][:description]
    )
      redirect_to tasks_path 
      return
    else 
      render :edit 
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy
    redirect_to tasks_path
    return
  end

  def complete
    @task = Task.find_by(id: params[:id])
    if @task.completion_date == nil
        @task.update(completion_date: Time.now)
    else
      @task.update(completion_date: nil)
    end
    redirect_to tasks_path
  end
end

