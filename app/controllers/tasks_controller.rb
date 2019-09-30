class TasksController < ApplicationController
  def index
    @tasks = %w(things I have to do)
  end
end
