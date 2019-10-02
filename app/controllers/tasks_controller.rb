TASKS = [
  { task: "Do Homework"},
  { task: "Make Dinner"},
  { task: "Clean Room"},
  { task: "Feed Pet"},
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
  
end
