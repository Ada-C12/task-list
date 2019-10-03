class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        task_id_raw = params[:id]
        task_id = task_id_raw.to_i
        @task = Task.find_by(id: task_id)
        if task_id.to_s != task_id_raw || @task.nil?
            redirect_to root_path
            return
        end
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new( name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date] )
        
        if @task.save
            redirect_to task_path(@task.id)
        else
            render new_book_path
        end
    end
end
