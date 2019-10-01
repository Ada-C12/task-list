# TASKS = [
#   "brush my teeth", "take my B12 vitamin drops", "laundry"
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
end
