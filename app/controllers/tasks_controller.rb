# TASKS = [
#   { title: "Hidden Figures", action: "Margot Lee Shetterly"},
#   { title: "Practical Object-Oriented Design in Ruby", action: "Sandi Metz"},
#   { title: "Kindred", action: "Octavia E. Butler"}
# ]
TASKS = [
  { title: "Hidden Figures", action: "Margot Lee Shetterly"},
  { title: "Practical Object-Oriented Design in Ruby", action: "Sandi Metz"},
  { title: "Kindred", action: "Octavia E. Butler"}
]

class TasksController < ApplicationController
  
  def index
    @tasks = TASKS
  end
  
end