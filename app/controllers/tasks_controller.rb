class TasksController < ApplicationController
  def index
    @tasks = ["laundry", "store"]
  end
end
