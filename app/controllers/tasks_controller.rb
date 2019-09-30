TASKS = [
  {title: "emails", description: "write some overdue replies", completion_date: Time.now + 1.days},
  {title: "plan road trip", description: "decide where you're going and plan snacks", completion_date: Time.now + 3.days},
  {title: "make soup", description: "shop for ingredients and make some soup", completion_date: Time.now + 5.days}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end  

  def show
    task_id = params[:id].to_i
    @task = TASKS[task_id]
    if @task.nil? 
      head :not_found
      return
    end 
  end 
end
