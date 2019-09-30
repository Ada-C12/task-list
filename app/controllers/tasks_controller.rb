TASKS = ['Walk Kaya', 'Feed Kaya', 'Entertain Kaya', 'Train Kaya', 'Buy Kayas food']

class TasksController < ApplicationController
  
  def index 
    @tasks = TASKS
  end 

end
