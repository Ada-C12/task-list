# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tasks = [
  {
    name: "defeat nemesis",
    description: "defeat archnemesis"
  },
  {
    name: "rescue cat",
    description: "rescue cat stuck in tree"
  },
  {
    name: "find sword",
    description: "find the lost hero's sword of myth and legend"
  },
  {
    name: "learn to shapeshift",
    description: "step one: acquire dire wolf, step two: ???"
  },
  {
    name: "defeat evil minions",
    description: "defeat nemesis's minions"
  }
]

task_failures = []
tasks.each do |task|
  new_task = Task.new
  new_task.name = task[:name]
  new_task.description = task[:description]
  
  successful = new_task.save
  if !successful
    task_failures << new_task
    puts "Failed to save task: #{new_task.inspect}"
  else
    puts "Created task: #{new_task.inspect}"
  end
end

puts "Added #{Task.count} task records"
puts "#{task_failures.length} tasks failed to save"
