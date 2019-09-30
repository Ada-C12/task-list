# app/controllers/books_controller.rb
TASKS = [
  { name: "Do Laundry", description: "don't mix colors"},
  { name: "Walk the dogs", description: "neighborhood stroll"},
  { name: "Bake a cake", description: "must include frosting"}
  
  
  class TasksController < ApplicationController
    def index
      @tasks = TASKS
    end
    
    def show
      task_id = params[:id].to_i
      @TASK = TASKS[task_id]
      
      if @task.nil?
        head :not_found
        return
      end
    end
    