

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @tasks = Task.find_by(id:task_id)
    if @tasks.nil?
      head :not_found
      return
    end
  end
end
