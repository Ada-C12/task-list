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
      #skip
      # Act
      get task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      #skip
      # Act
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new task page" do
      #skip
      
      # Act
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new task" do
      #skip
      
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
      #skip
      # Your code here
      get edit_task_path(task.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      # Your code here
      get edit_task_path(5000)
      must_respond_with :not_found
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      @valid_task = Task.create(name: "Buy Milk", description: "Whole Milk", completed: nil)
    end
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test. 
    
    it "updates an existing passenger successfully and redirects to home" do
      
      existing_task = Task.first
      
      updated_task_hash = {
        task: {
          name: "Buy OJ",
          description: "Lots of Pulp", 
          completed: nil
        }
      }
      
      expect {
        patch task_path(existing_task.id), params: updated_task_hash
      }.wont_change 'Task.count'
      
      # Assert
      expect( Task.find_by(id: existing_task.id).name ).must_equal "Buy OJ"
      expect( Task.find_by(id: existing_task.id).description ).must_equal "Lots of Pulp"
    end
    
    
    it "will redirect to the root page if given an invalid id" do
      get task_path("5000")
      must_respond_with :not_found
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it 'deletes a new task successfully with valid data, and redirects the user to the task page' do
      
      task_hash = {
        task: {
          name: "Take Over the World",
          description: "One New Non-CIS Male Dev at a Time",
          completion: nil
        }
      }
      
      post tasks_path, params: task_hash
      identifier = Task.find_by(name: "Take Over the World")
      
      expect {
        delete task_path(identifier.id)
      }.must_differ 'Task.count', -1
      
      must_redirect_to tasks_path
    end
    
  end
  
  # Complete for Wave 4
  describe "mark_complete" do
    # Your tests go here
  end
end
