# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
random_time = Date.today

tasks = Task.create([
  {name: "The First Task", description: "feed cats", completion_date: random_time},
  {name: "Go to Brunch", description: "text Nicole when you're on your way"},
  {name: "Go to Lunch", description: "but you just ate brunch", completion_date: random_time},
  {name: "Go to Second Lunch", description: ""},
  {name: "Play Video Games", description: "stardew valley", completion_date: random_time},
  {name: "High Five Somebody You Don't Know", description: "just pick anyone", completion_date: random_time},
  {name: "Plant Flowers", description: "", completion_date: random_time},
  {name: "Call Mom", description: "if you have an extra 2 hours..."},
  {name: "Nap.", description: "with Mr. Beans", completion_date: random_time}
  ])
  