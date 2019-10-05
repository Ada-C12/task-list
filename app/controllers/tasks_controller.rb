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
        @task = Task.new(task_params)
        begin
            @task.save!
        rescue ActiveRecord::RecordInvalid
            redirect_to new_task_path
            return
        end 
        
        redirect_to task_path(@task.id)   
        return    
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
            
            begin
                @task.save!
            rescue ActiveRecord::RecordInvalid
                redirect_to edit_task_path(@task.id)
                return
            end 
            
            redirect_to task_path(@task.id)
            return
        else
            redirect_to tasks_path
            return
        end  
    end
    
    def destroy
        selected_task = Task.find_by(id: params[:id])
        
        if !selected_task
            redirect_to tasks_path
            return
        else
            selected_task.destroy
            redirect_to tasks_path
            return
        end
    end
    
    def mark_complete
        @task = Task.find_by(id: params[:id])
        if @task
            @task.completion_date = (@task.completion_date) ? nil : Date.current()
            @task.save
        end 
        redirect_to tasks_path
        return
    end
    
    private
    def task_params
        return params.require(:task).permit(:name, :description, :completion_date)
    end
end
