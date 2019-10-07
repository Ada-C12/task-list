require "test_helper"

describe TasksController do
  let (:task) {
  Task.create name: "sample task", description: "this is an example for a test",
  completion_date: Time.now + 5.days
}

# Tests for Wave 1
describe "index" do
  it "can get the index path" do
    # Act
    get tasks_path
    
    # Assert
    must_respond_with :success
  end
  
  it "can get the root path" do
    # Act
    get root_path
    
    # Assert
    must_respond_with :success
  end
end

# Unskip these tests for Wave 2
describe "show" do
  it "can get a valid task" do
    
    # Act
    get task_path(task.id)
    
    # Assert
    must_respond_with :success
  end
  
  it "will redirect for an invalid task" do
    
    # Act
    get task_path(-1)
    
    # Assert
    must_respond_with :redirect
    
  end
end

describe "new" do
  it "can get the new task page" do
    
    
    # Act
    get new_task_path
    
    # Assert
    must_respond_with :success
  end
end

describe "create" do
  it "can create a new task" do
    
    
    # Arrange
    task_hash = {
    task: {
    name: "new task",
    description: "new task description",
    completion_date: nil,
  },
}

# Act-Assert
expect {
post tasks_path, params: task_hash
}.must_change "Task.count", 1

new_task = Task.find_by(name: task_hash[:task][:name])
expect(new_task.description).must_equal task_hash[:task][:description]

expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

must_respond_with :redirect
must_redirect_to task_path(new_task.id)
end
end

# Unskip and complete these tests for Wave 3
describe "edit" do
  it "can get the edit page for an existing task" do
    # Act
    get edit_task_path(task.id)

    # Assert
    must_respond_with :success
  end
  
  it "will respond with redirect when attempting to edit a nonexistant task" do
    # Act
    get edit_task_path(1337)

    # Assert
    must_respond_with :redirect
    must_redirect_to tasks_path
  end
end

# Uncomment and complete these tests for Wave 3
describe "update" do
  # Note:  If there was a way to fail to save the changes to a task, that would be a great
  #        thing to test.
  it "can update an existing task" do
    # Arrange
    task_hash = {
      task: {
        name: "sample task", 
        description: "this is an updated description of the task",
        id: task.id
      }
    }

    # Act
    patch task_path(task.id), params: task_hash

    task.reload

    # Assert
    expect(task.name).must_equal task_hash[:task][:name]
    expect(task.description).must_equal task_hash[:task][:description]

    must_respond_with :redirect
    must_redirect_to tasks_path
  end
  
  it "will redirect to the root page if given an invalid id" do
    # Arrange
    task_hash = {
      task: {
        name: "sample task", 
        description: "this is an updated description of the task",
      }
    }

    # Act
    patch task_path(1337), params: task_hash

    # Assert
    must_respond_with :redirect
    must_redirect_to tasks_path

  end
end

# Complete these tests for Wave 4
describe "destroy" do
  before do 
    @task = Task.create name: "sample task", description: "this is an example for a test",
    completion_date: Time.now + 5.days
  end
  it 'will decrease the count of the tasks in the database by 1' do
    expect{delete task_path(@task.id)}.must_differ 'Task.count', -1
    
    must_respond_with :redirect 
  end
end
  

# Complete for Wave 4
describe "toggle_complete" do
  before do 
    Time.zone = 'Pacific Time (US & Canada)'
    @task = Task.create name: "sample task", description: "this is an example for a test"
  end

  it "will add the date to completed_date when marked completed" do
    # Arrange
    
    task_hash = {
      task: {
        name: "sample task", 
        description: "this is an updated description of the task",
        completion_date: DateTime.now.in_time_zone,
      }
    }

    # Act
    patch completed_task_path(@task.id), params: task_hash

    @task.reload

    expect(@task.completion_date).wont_be_nil
    must_respond_with :redirect 
    must_redirect_to tasks_path
  end

  it "will change the completion_date to nil when marked incomplete" do
  # Arrange
    
  task_hash = {
    task: {
      name: "sample task", 
      description: "this is an updated description of the task",
      completion_date: nil,
    }
  }

  # Act
  patch incomplete_task_path(@task.id), params: task_hash

  @task.reload

  expect(@task.completion_date).must_be_nil
  must_respond_with :redirect 
  must_redirect_to tasks_path
  end
end  
end

