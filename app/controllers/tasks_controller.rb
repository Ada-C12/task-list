class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        task_id = params[:id].to_i
        @task = Task.find_by(id: task_id)
        if @task.nil?
            head :redirect
            return
        end
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new( task_params )
        
        if @task.save
            redirect_to task_path(@task.id)
        else
            render new_book_path
        end
    end
    
    
    
    private 
    def task_params
        # The responsibility of this method is to return "strong params"
        # .require is used when we use form_with and a model, and therefore our expected form data has the "book" hash inside of it
        # .permit takes in a list of names of attributes to allow... (aka the new Book form has title, author, description)
        return params.require(:task).permit(:name, :description, :completion_date)
        
        # Remember: If you ever update the database, model, and form, this will also need to be updated
    end
end

