TASKS = ["make bed", "get groceries", "walk dog", "feed dog", "cuddle dog"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
