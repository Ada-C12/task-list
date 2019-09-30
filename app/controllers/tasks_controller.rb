
TASKS = ["Cleaning", "Grocery", "Cooking", "Laundry"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
