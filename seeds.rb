tasks = [
  {name: "The First Task", description: ""},
  {name: "Go to Brunch", description: ""},
  {name: "Go to Lunch", description: ""},
  {name: "Go to Second Lunch", description: ""},
  {name: "Play Video Games", description: ""},
  {name: "High Five Somebody You Don't Know", description: ""},
  {name: "Plant Flowers", description: ""},
  {name: "Call Mom", description: ""},
  {name: "She worries, you know.", description: ""},
  {name: "Nap.", description: ""},
]

tasks.each do |task|
  Task.create task
end
