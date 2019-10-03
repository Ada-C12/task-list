require 'time'

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date] )

    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
end

# notes from lecture

# it "updates ane xisting task successfully and reidrects to home" do
#   #find an existing task and its id
#   book_to_update_id = Book.last.id

#   #Act
#   #update teh book data

#   #assert
#   updated_book = Book.find_by(id: book_to_update_id)
#   expect(updated_book.title).must_equal "updated value"
# end