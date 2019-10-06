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
      # skip
      # Act
      get task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      # skip
      # Act
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new task page" do
      # skip
      
      # Act
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new task" do
      # skip
      
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
      # skip
      # Your code here
      get edit_task_path(task.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
      # Your code here
      get edit_task_path(-1)
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "can update an existing task" do
      # Your code here
      new_values = {
        name: "new name",
        description: "new description"
      }
      task.update(new_values)
      expect(task.name).must_equal new_values[:name]
      expect(task.description).must_equal new_values[:description]
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
      get '/tasks/-1'
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "successfully deletes an existing Task and then redirects to home page" do
      task
      expect{
        delete task_path(task.id)
      }.must_differ "Task.count", -1
      must_redirect_to root_path
    end
    
    it "redirects to index page and deletes nothing if no task exist" do 
      expect{
        delete task_path(-1)
      }.must_differ "Task.count", 0
      must_redirect_to tasks_path
    end
  end
  
  describe "complete" do
    # Your tests go here
    it "must update the completed time to now and redirect to index page" do
      new_values = {
        name: "new name",
        description: "new description"
      }
      new_task = Task.create(new_values)
      expect(new_task.completed).must_be_nil
      
      patch complete_task_path(new_task.id)
      find_new_task = Task.find_by(id: new_task.id)
      
      expect(find_new_task.completed).must_be_instance_of ActiveSupport::TimeWithZone
      must_redirect_to tasks_path
    end
  end
  
  describe "uncomplete" do
    # Your tests go here
    it "must update the completed time to nil and redirect to index page" do
      patch uncomplete_task_path(task.id)
      uncomplete_task = Task.find_by(id: task.id)
      
      expect(uncomplete_task.completed).must_be_nil 
      must_redirect_to tasks_path
    end
  end
end