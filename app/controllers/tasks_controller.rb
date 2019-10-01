
TASKS = [
  { name: "walk the dog", priority: "low" },
  { name: "brush your teeth", priority: "high" },
  { name: "fold laundry", priority: "medium" }
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
  
  
end
