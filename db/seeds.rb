# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tasks = Task.create([
  {name: "The First Task", description: "Wake up", completion_date: Date.today},
  {name: "Go to Brunch", description: "Eats lots of yummy food and drink coffee"},
  {name: "Go to Lunch", description: "Eat more food"},
  {name: "Go to Second Lunch", description: "Eat a snack. Maybe take a nap."},
  {name: "Play Video Games", description: "Download Untitled Gooose Game", completion_date: Date.today},
  {name: "High Five Somebody You Don't Know", description: "Use hand sanitizer after. It's cold season", completion_date: Date.today},
  {name: "Plant Flowers", description: "Get some pots first.", completion_date: Date.today},
  {name: "Call Mom", description: "She worries, you know."},
  {name: "Nap.", description: "Period.", completion_date: Date.today}])

  puts "Total Tasks added: #{Task.count} / 9"
