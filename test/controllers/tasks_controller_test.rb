require "test_helper"

describe TasksController do
  
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed: Time.now + 5.days
  }
  
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
  
  describe "create action" do
    it "can create a new task" do
      
      # Arrange test data
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed: nil
        }
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change 'Task.count', 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal task_hash[:task][:completed]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  describe "edit" do
    
    task_hash = {
      task: {
        name: "task to be edited",
        description: "task to be edited description",
        completed: nil,
      }
    }
    
    it "can get the edit page for an existing task" do
      
      # Act
      get edit_task_path(task)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when attempting to edit a nonexistant task" do
      # Act
      get edit_task_path(5000)
      
      # Assert
      must_respond_with :redirect
    end
    
  end
  
  describe "update" do
    before do 
      @new_task = Task.create(name: "new task")
    end
    
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    
    it "updates an existing task then redirects to task page" do
      
      # Arrange: find an existing task ...
      existing_task = Task.first
      
      # Act: ... and update the data
      updated_task_form_data = {
        task: {
          name: "Updated task", 
          description: "Updated task description",
          completed: nil
        }
      }
      
      # Assert
      
      expect {
        patch task_path(existing_task.id) , params: updated_task_form_data
      }.wont_change 'Task.count'
      
      expect( Task.find_by(id: existing_task.id).name ).must_equal "Updated task"
      
      expect( Task.find_by(id: existing_task.id).description ).must_equal "Updated task description"
      
      must_redirect_to task_path

    end
    
    it "redirects to the root page if given an invalid id" do
      
      # Arrange
      invalid_id = -5
      
      # Act
      patch task_path(invalid_id)
      
      # Assert
      must_redirect_to root_path
      
    end
    
  end
  
  describe "destroy" do
    
    it "removes a task from the task list and redirects to tasks list" do
      # Arrange: make sure our task list has at least one object ... 
      new_task = Task.create(name: "New task")
      
      # ... and designate an existing task to be deleted
      to_be_deleted = Task.first
      
      # Act/Assert: delete the task and confirm that the task list is one object shorter
      
      expect{
        delete task_path(to_be_deleted.id)
      }.must_differ 'Task.count', -1

      must_redirect_to tasks_path
      
    end

    it "will redirect to the root page if given an invalid id" do
      
      # Arrange
      invalid_id = -5
      
      # Act
      delete task_path(invalid_id)
      
      # Assert
      must_redirect_to root_path
      
    end
    
    
  end
  
  describe "toggle_complete" do
    # Your tests go here
  end
  
end # final end


