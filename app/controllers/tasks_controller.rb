TASKS = [
  { task: "Make breakfast" },
  { task: "Make bed" },
  { task: "Brush teeth" },
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
