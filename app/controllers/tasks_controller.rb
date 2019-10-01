TASKS = [
  {name: 'wash the dishes', status: 'incomplete'},
  {name: 'walk the dog', status: 'incomplete'},
  {name: 'vacuum', status: 'incomplete'}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
