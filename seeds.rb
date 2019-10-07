def random_time
  Time.at(rand * Time.now.to_i)
end

tasks = [
  {name: "The First Task", description: "", completion_date_at: random_time},
  {name: "Go to Brunch", description: ""},
  {name: "Go to Lunch", description: "", completion_date_at: random_time},
  {name: "Go to Second Lunch", description: ""},
  {name: "Play Video Games", description: "", completion_date_at: random_time},
  {name: "High Five Somebody You Don't Know", description: "", completion_date_at: random_time},
  {name: "Plant Flowers", description: "", completion_date_at: random_time},
  {name: "Call Mom", description: ""},
  {name: "She worries, you know.", description: ""},
  {name: "Nap.", description: "", completion_date_at: random_time},
]

tasks.each do |task|
  Task.create task
end
