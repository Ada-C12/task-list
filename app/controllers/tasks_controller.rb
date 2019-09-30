class TasksController < ApplicationController
  
  TASKS = %w[laundry dishes homework mail gardening]
  def index 
    @tasks = TASKS
  end
end
