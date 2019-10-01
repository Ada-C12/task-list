class TasksController < ApplicationController
  TASKS = [
  "Do CS Fun homework",
  "Cook turkey chili",
  "Vaccuum room",
  "Go for a run"]
  
  def index
    @tasks = TASKS
  end
end
