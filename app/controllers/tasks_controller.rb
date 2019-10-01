TASKS = ["laundry", "grocery shopping", "hygiene", "take out recycling", "complete Ada's Ruby on Rails project"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end


end
