TASKS = ["save city from evil dragon", "find the lost hero's sword", "defeat arch-nemesis's minions", "defeat arch-nemesis", "rescue cat stuck in tree"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
