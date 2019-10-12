# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
tasks = Task.create([{
name: "Find a pet",
description: "Go to the shelter",
completed: nil
},
{
name: "Clean computer",
description: "Wipe down screen",
completed: nil
},
{
name: "Buy present for Mom",
description: "Find something without any ingredients",
completed: nil
}
]
)