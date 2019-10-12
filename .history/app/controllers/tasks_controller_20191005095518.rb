class TasksController < ApplicationController
    def index
        @tasks = TASKS
    end
    TASKS = ["Clean room", "Do laundry", "Wash dishes", "Go grocery shopping"]
    
end

end
