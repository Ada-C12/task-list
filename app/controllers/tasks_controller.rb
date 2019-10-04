# TASKS = [
#   {title: "emails", description: "write some overdue replies", completion_date: Time.now + 1.days},
#   {title: "plan road trip", description: "decide where you're going and plan snacks", completion_date: Time.now + 3.days},
#   {title: "make soup", description: "shop for ingredients and make some soup", completion_date: Time.now + 5.days}
# ]

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
    @task = Task.new
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: nil) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task) # go to the new task page
      return
    else # save failed :(
      render :new # show the new task form view again
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
    if params[:completed] == 1
      update_completed = Time.now 
    else 
      update_completed = nil
    end 
    if @task.update(
      name: params[:task][:name],
      description: params[:task][:description],
      completed: update_completed
    )
    redirect_to tasks_path
    return
  else
    render :edit
    return
  end 
end

def destroy
  task_id = params[:id]
  @task = Task.find_by(id: task_id)
  
  if @task.nil? 
    redirect_to tasks_path
    return
  end 
  
  @task.destroy 
  
  redirect_to tasks_path
  return 
end 

end
