def random_time
  Time.at(rand * Time.now.to_i)
end

tasks = [
  {name: "The First Task", description: "", completed: random_time},
  {name: "Go to Brunch", description: ""},
  {name: "Go to Lunch", description: "", completed: random_time},
  {name: "Go to Second Lunch", description: ""},
  {name: "Play Video Games", description: "", completed: random_time},
  {name: "High Five Somebody You Don't Know", description: "", completed: random_time},
  {name: "Plant Flowers", description: "", completed: random_time},
  {name: "Call Mom", description: ""},
  {name: "She worries, you know.", description: ""},
  {name: "Nap.", description: "", completed: random_time},
]

tasks.each do |task|
  Task.create task
end
