# TASKS = [
#   { name: "Study", description: "Finish Wave 4 homework", completion_date: nil},
#   { name: "Clean house", description: "Sweep and mop the floors", completion_date: nil},
#   { name: "Buy groceries", description: "Buy all of trader joes", completion_date: nil}
# ]

class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id:task_id)
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    task_params = params[:task]
    task = Task.new(name: task_params[:name], description: task_params[:description])
    task.save
    
    redirect_to task_path(task)
  end
end

# def create
#   @book = Book.new(author: params[:book][:author], title: params[:book][:title], description: params[:book][:description]) #instantiate a new book
#   if @book.save # save returns true if the database insert succeeds
#     redirect_to books_path # go to the index so we can see the book in the list
#     return
#   else # save failed :(
#     render :new # show the new book form view again
#     return
#   end
# end