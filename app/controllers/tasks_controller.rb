TASKS = ["wash sheets", "finish homework", "shower", "make lunch for tomorrow"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
