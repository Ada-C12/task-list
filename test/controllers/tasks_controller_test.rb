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
    before do
      Task.create(name: "Sweep the floors", description: "Grab a broom!", completion_date: nil)
    end
    
    let (:new_task_details) {
      {
        task: {
          name: "Clean your room",
          description: "Get tidy!",
          completion_date: Time.now + 1.days
        }
      }
    }
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      
      current_id = Task.first.id
      
      expect {
        patch task_path(current_id), params: new_task_details
      }.must_differ "Task.count", 0
      
      must_respond_with :redirect
      must_redirect_to task_path
      
      current_task = Task.find_by(id: current_id)
      expect(current_task.name).must_equal new_task_details[:task][:name]
      expect(current_task.description).must_equal new_task_details[:task][:description]
      expect(current_task.completion_date).wont_be_nil
      
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
      invalid_id = - 1
      
      patch task_path(invalid_id), params: new_task_details
      
      must_redirect_to root_path
      
      
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "successfully deletes the selected task and redirects back to the list of tasks" do
      Task.create(name: "Test task!", description: "Testing this task", completion_date: nil)
      valid_id = Task.find_by(name: "Test task!").id
      expect {delete task_path(valid_id)}.must_differ "Task.count", -1
      must_redirect_to tasks_path
    end
    
    it "does not delete any tasks and redirects back to the list of tasks if the given task does not exist" do
      Task.destroy_all
      invalid_id = 1
      
      expect {delete task_path(invalid_id)}.must_differ "Task.count", 0
      must_redirect_to tasks_path
    end
    
    it "does not delete any tasks and redirects to the list of tasks if the user tries to delete a task that was already deleted" do
      Task.create(name: "Another test task!", description: "Testing this task again", completion_date: nil)
      valid_id = Task.find_by(name: "Another test task!").id
      delete task_path(valid_id)
      expect {delete task_path(valid_id)}.must_differ "Task.count", 0
      must_redirect_to tasks_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    
    
  end
end
