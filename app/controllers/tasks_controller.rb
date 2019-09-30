TASKS = [
    "Finish homework",
    "Do laundry",
    "Water plants",
    "Feed Tofu",
    "Walk Tofu"
]

class TasksController < ApplicationController
    def index
        @tasks = TASKS
    end
end
