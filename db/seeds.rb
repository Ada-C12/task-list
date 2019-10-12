# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tasks = Task.create(
  [{name: "Walk Kaya", description: "20 mins walk", completed: nil}, {name: "Feed Kaya", description: "She's a fatty. Give lots of treats", completed: nil}, {name: "Train Kaya", description: "She only responds to treats", completed: nil}, {name: "Cuddle Kaya", description: "She hates it. Do it anyways hehehe", completed: nil}]
)
