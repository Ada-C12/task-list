TASKS = ["clean your room", "clean the bathroom", "clean the kitchen"]


class TasksController < ApplicationController

  def index
    @tasks = TASKS
  end

end
