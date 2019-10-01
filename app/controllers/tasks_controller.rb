# completion_date: Time.now + 1.days

TASKS = [ 
  {name: "scoop litter", description: "scoop the poop"},
  {name: "feed cat", description: "feed half a can of wet food"},
  {name: "groom cat", description: "run furminator through the cat"}
]


class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
