TASKS = ["feed cat", "do laundry", "cook dinner", "finish homework"]

class TasksController < ApplicationController

  def index
    @tasks = TASKS
  end

end
