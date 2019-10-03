class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show
        task_id = params[:id].to_i
        @task = Task.find_by(id: task_id)

        if task_id < 0
            flash[:Error] = "Could not find task with id: -1"
            # redirect_to "Could not find task with id: -1"
        end

        if @task.nil?
            redirect_to new_task_path
            return
        end
         
    end

    def new
        @task = Task.new
    end

    def create
        # task_name = params[:name]
        # task_description = params[:description]
        # task = Task.create(
        #     name: task_name,
        #     description: task_description
        # )

        # redirect_to :controller => 'tasks', :action => 'index'
        
        @task = Task.new( 
            name: params[:task][:name], 
            description: params[:task][:description]
        )

        if @task.save
            redirect_to task_path(@task.id)
        else
            render new_task_path
        end
    end
    
    def edit
        @task = Task.find_by(id: params[:id] )
    end
        
    def update
        @task = Task.find_by(id: params[:id])
        @task[:name] = params[:task][:name]
        @task[:description] = params[:task][:description]
                
        if @task.save
            redirect_to task_path(@task.id)
        else
            render new_task_path
        end
    end

    def destroy
        task_to_delete = Task.find_by(id: params[:id])
        if task_to_delete.nil?
            redirect_to tasks_path
            return
        else
            task_to_delete.destroy
            redirect_to root_path
            return
        end
    end
    
end
    

