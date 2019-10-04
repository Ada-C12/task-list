require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed: Time.now + 5.days
  }
  
  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get "/tasks"
      
      # Assert
      must_respond_with :success
    end
    
    it "can get the root path" do
      # Act
      get "/"
      
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
          completed: nil,
        },
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal task_hash[:task][:completed]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Your code here
    end
  end
  
  describe "update" do
    before do
      @new_task = Task.create(name: "new task")
    end
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      existing_task = Task.first
      updated_task_form_data = {
        task: {
          name: "Melt chocolate",
          description: "Whisk chocolate shavings into saucepan on low heat until melted",
          completed: 10-06-2019
        }
      }
      expect {
        patch task_path(existing_task.id), params: updated_task_form_data
        must_redirect_to root_path
      }
      
      # .wont_change 'Task.count'
      
      expect( Task.find_by(id: existing_task.id).name ).must_equal "MyString"
    end
  end
  
  it "will redirect to the root page if invalid id is given" do
    invalid_id = "anything"
    updated_task_form_data = {
      task: {
        name: "Melt chocolate",
        description: "Whisk chocolate shavings into saucepan on low heat until melted",
        completed: 10-06-2019
      }
    }
    patch task_path(invalid_id), params: updated_task_form_data
    must_respond_with :redirect
    must_redirect_to root_path
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end

