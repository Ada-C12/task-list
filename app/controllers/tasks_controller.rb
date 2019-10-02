class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      # flash[:error] = "Could not find task with id: #{task_id}"
      # redirect_to "/tasks"
      redirect_to '/tasks'
      # , flash: {error: "Could not find task with id: #{task_id}"}
      return
    end
  end
end


# must_respond_with :redirect
# expect(flash[:error]).must_equal "Could not find task with id: -1"