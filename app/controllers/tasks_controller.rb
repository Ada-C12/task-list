TASKS = [
  { name: "mail package", description: "send to Milton", completion_date: Time.now + 3.days},
  { name: "clean kitchen", description: "wash dishes, mop floor", completion_date: Time.now + 1.days},
  { name: "complete homework", description: "task list project", completion_date: Time.now + 7.days},
  { name: "feed dog", description: "treats to Max", completion_date: Time.now + 3.hours}
]


class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
