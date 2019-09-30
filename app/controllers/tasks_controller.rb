class TasksController < ApplicationController
  
  TASKS = ["wash sheets", "finish homework", "shower", "make lunch for tomorrow"]
  
  def index
    @tasks = TASKS
  end
  
end
