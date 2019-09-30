TASKS = [
"wash dishes", "do laundry", "grocery shopping", "buy birthday present"
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
