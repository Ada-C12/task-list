TASKS = [
  { title: "Water Plants", responsible: "Daniela"},
  { title: "Feed Dog", responsible: "Alex"},
  { title: "Call Insurance", responsible: "Daniela"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
