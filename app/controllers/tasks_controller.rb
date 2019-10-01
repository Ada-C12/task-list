
#TASKS = [ "Cleaning", "Grocery", "Cooking", "Laundry" ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
end
