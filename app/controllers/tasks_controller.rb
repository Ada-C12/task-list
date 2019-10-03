class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        task_id_raw = params[:id]
        task_id = task_id_raw.to_i
        @task = Task.find_by(id: task_id)
        if task_id.to_s != task_id_raw || @task.nil?
            redirect_to tasks_path
            return
        end
    end
    
    def new
        @task = Task.new
    end
    
    def create
        hash_info = {
            name: params[:task][:name],
            description: params[:task][:description],
            completion_date: params[:task][:completion_date]
        }
        
        @task = Task.new(hash_info)
        if @task.save
            redirect_to task_path(@task.id)
        else
            render new_book_path
        end
    end
    
    def edit
        @task = Task.find_by(id: params[:id])
        if @task.nil?
            redirect_to tasks_path
            return
        end
    end
    
    def update
        @task = Task.find_by(id: params[:id])
        if @task
            @task.name = params[:task][:name]
            @task.description = params[:task][:description]
            @task.completion_date = params[:task][:completion_date]
            
            if @task.save
                redirect_to task_path(@task.id)
            else
                render new_task_path
            end
        else
            redirect_to tasks_path
        end  
    end
end
