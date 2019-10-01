TASKS = [
  {title: "buy more kitty litter", date: "09/30/2019", status: :incomplete},
  {title: "buy more wet cat food", date: "09/30/2019", status: :complete}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
