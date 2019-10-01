
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    # convert to integer so we can index into the array
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    end

  end
end
