tasks = [
    {
        name: "Task1",
        description: "Task 1 description",
        completion_date: Date.current
    },
    {
        name: "Task2",
        description: "Task 2 description",
        completion_date: Date.current
    },
    {
        name: "Task3",
        description: "Task 3 description",
        completion_date: Date.current
    },
    {
        name: "Task4",
        description: "Task 4 description",
        completion_date: Date.current
    },
    {
        name: "Task5",
        description: "Task 5 description",
        completion_date: Date.current
    },
    {
        name: "Task6",
        description: "Task 6 description",
        completion_date: Date.current
    },
    {
        name: "Task7",
        description: "Task 7 description",
        completion_date: Date.current
    },
    {
        name: "Task8",
        description: "Task 8 description",
        completion_date: Date.current
    }
]

task_failures = []
tasks.each do |input_task|
  task = Task.new(input_task)
  successful = task.save
  if successful
    puts "Created task: #{task.inspect}"
  else
    task_failures << task
    puts "Failed to save task: #{task.inspect}"
  end
end