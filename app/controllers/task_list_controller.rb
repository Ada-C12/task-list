  TASKS = [
    {task: "Do homework"},
    {task: "Relax little"},
    {task: "Come to class tomorrow"},
  ]

class TaskListController < ApplicationController

        def index
            @tasks = TASKS
        
        end
      
end
