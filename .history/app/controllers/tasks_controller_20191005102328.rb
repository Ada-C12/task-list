class TasksController < ApplicationController
    def index
        @tasks = TASKS
    end
    
end

