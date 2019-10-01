TASKS = ["Laundry", "Feed Babette", "Clean room", "Sleep"] 

class TasksController < ApplicationController

  def index
    @tasks = TASKS
  end


end
