require "test_helper"

describe TasksController do
  let (:task) {
  Task.create name: "sample task", description: "this is an example for a test",
  completed: Time.now + 5.days }
  
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
  
  # Tests for Wave 2
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
      task_hash = { task: 
      { name: "new task", description: "new task description", completed: nil }}
      
      # Act-Assert
      expect { post tasks_path, params: task_hash }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      assert_nil(new_task.completed)
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Tests for Wave 3
  describe "edit" do  
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a non-existant task" do
      # Act
      get edit_task_path(-1)
      
      # Assert
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "can update an existing task" do
      # Arrange
      task_hash = { task: 
      { name: "new task", description: "new task description", completed: nil}}
      
      # Act-Assert
      patch task_path(task.id), params: task_hash
      
      updated_task = Task.find_by(id: task.id)
      
      expect(updated_task.name).must_equal task_hash[:task][:name]
      expect(updated_task.description).must_equal task_hash[:task][:description]
      assert_nil(updated_task.completed)
      
      must_respond_with :redirect
      must_redirect_to task_path
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Arrange
      task_hash = { task: 
      { name: "new task", description: "new task description", completed: nil }}
      
      # Act-Assert
      patch task_path(-1), params: task_hash
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Tests for Wave 4
  describe "destroy" do
    it "reduces the total task count by 1" do  
      test_task = task
      
      expect{ delete task_path(test_task.id) }.must_differ "Task.count", -1
    end
    
    it "removes the record from the database" do
      delete task_path(task.id)
      
      updated_task = Task.find_by(id: task.id)
      
      assert_nil(updated_task)
      must_redirect_to root_path  
    end
  end
  
  describe "toggle_complete" do
    it "correctly changes a task from complete to not_complete" do
      patch not_complete_task_path(task.id)
      
      updated_task = Task.find_by(id: task.id)
      
      assert_nil(updated_task.completed)
    end    
    
    it "correctly changes a task from not_complete to complete" do
      task2 = Task.create(name: "sample task 2", description: "this is an example", completed: nil)
      
      patch complete_task_path(task2.id)
      
      updated_task = Task.find_by(id: task2.id)
      
      expect(updated_task.completed).must_be_instance_of ActiveSupport::TimeWithZone
    end
  end
end
