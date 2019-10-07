
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
    @task = Task.new(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completion_date: params[:task][:completion_date]) #instantiate a new task
      if @task.save # save returns true if the database insert succeeds
        redirect_to task_path(@task.id) # go to the index so we can see the task in the list
        return
      else # save failed :(
        render :new # show the new task form view again
        return
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
      if @task.nil? 
        redirect_to tasks_path
      else 
        @task.update(
          name: params[:task][:name], 
          description: params[:task][:description],
          completion_date: params[:task][:completion_date],
          completed: params[:task][:completed]
        )
        redirect_to tasks_path # go to the index so we can see the task in the list
      end
      #   return
      # else # save failed :(
      #   render :edit # show the new task form view again
      #   return
    end
    
    def complete
      @task = Task.find_by(id: params[:id])
      if @task[:completed] == false
        @task[:completed] = true
        @task[:completion_date] = Time.now
      else
        @task[:completed] = false
        @task[:completion_date] = nil
      end
      @task.save
      redirect_to tasks_path
    end
    
    def destroy
      task_id = params[:id]
      @task = Task.find_by(id: task_id)
      if @task.nil?
        head :not_found
        return
      end
      
      @task.destroy
      
      redirect_to tasks_path
      return
    end
    
    def task_params
      return params.require(:task).permit(:name, :description, :completion_date, :due_date, :completed)
    end
    
  end#end of class