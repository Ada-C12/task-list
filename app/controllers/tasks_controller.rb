TASKS = [
{ title: "Hidden Figures", author: "Margot Lee Shetterly"},
{ title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
{ title: "Kindred", author: "Octavia E. Butler"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
