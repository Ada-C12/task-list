TASKS = [
  "return library books",
  "order cupcakes",
  "plant plants",
  "prune hydrangeas"
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
