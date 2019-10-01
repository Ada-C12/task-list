TASKS = [
  {task: "walk taro"}, {task: "feed taro"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
  
end