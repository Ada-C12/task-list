# app/controllers/tasks_controller.rb
# TASKS = [
#   { name: "Do Laundry", description: "don't mix colors"},
#   { name: "Walk the dogs", description: "neighborhood stroll"},
#   { name: "Bake a cake", description: "must include frosting"}
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all 
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      head :not_found
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end
end
