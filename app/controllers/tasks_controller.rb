TASKS = [
  { name: "Hidden Figures", description: "Margot Lee Shetterly"},
  { name: "Practical Object-Oriented Design in Ruby", description: "Sandi Metz"},
  { name: "Kindred", description: "Octavia E. Butler"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end

