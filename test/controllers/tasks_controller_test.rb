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
      
      get edit_task_path(task.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
      
      # Act
      get edit_task_path(646594)
      
      # Assert
      must_respond_with :redirect
      must_redirect_to '/tasks'
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    
    existing_task = Task.create(name: "sample task", description: "this is an example for a test")
    update_info = {
      task: {
        name: "Write tests",
        description: "Write tests for tasks controller update method"
      }
    }
    
    it "can update an existing task" do
      patch task_path(existing_task.id), params: update_info
      
      updated_task = Task.find_by(id: existing_task.id)
      expect(updated_task.name).must_equal update_info[:task][:name]
      expect(updated_task.description).must_equal update_info[:task][:description]
      expect(updated_task.completion_date).must_be_nil update_info[:task][:completion_date]
      
      must_respond_with :redirect
      must_redirect_to task_path(updated_task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch task_path(54645656456), params: update_info
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    task = Task.create(name: "sample task", description: "this is an example for a test")
    
    it "deletes an existing book successfully" do
      expect {
        delete task_path( task.id )
      }.must_differ "Task.count", -1
      
      must_redirect_to root_path
    end
    
    it "redirects if book is not available to delete" do
      expect {
        delete task_path( 500 )
      }.must_differ "Task.count", 0
      
      must_redirect_to tasks_path
    end
    
    it "redirects if book has already been deleted" do
      Task.destroy_all
      expect {
        delete task_path( task.id )
      }.must_differ "Task.count", 0
      
      must_redirect_to tasks_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    task = Task.create(name: "sample task", description: "this is an example for a test")
    task2 = Task.create(name: "sample task", description: "this is an example for a test")
    
    it "stores completed tasks time in database" do
      @task = Task.find_by(id: task.id)
      
      patch "/tasks", params: { task_ids: [task.id] }
      completed_task = Task.find_by(id: task.id)
      
      must_respond_with :redirect
      must_redirect_to tasks_path
      expect completed_task.completion_date != nil
    end
    
    it "stores multiple completed tasks times in database" do
      @task = Task.find_by(id: task.id)
      @task2 = Task.find_by(id: task2.id)
      
      patch "/tasks", params: { task_ids: [task.id, task2.id] }
      completed_task = Task.find_by(id: task.id)
      completed_task2 = Task.find_by(id: task2.id)
      
      must_respond_with :redirect
      must_redirect_to tasks_path
      expect completed_task.completion_date != nil
      expect completed_task2.completion_date != nil
    end
    
    it "removes stored task time from database if unchecked" do
      @task = Task.find_by(id: task.id)
      @task2 = Task.find_by(id: task2.id)
      
      patch "/tasks", params: { task_ids: [task.id] }
      @completed_task = Task.find_by(id: task.id)
      @completed_task2 = Task.find_by(id: task2.id)
      
      patch "/tasks", params: { task_ids: [task.id] }
      uncompleted_task = Task.find_by(id: task2.id)
      
      must_respond_with :redirect
      must_redirect_to tasks_path
      expect uncompleted_task.completion_date = nil
    end
  end
end
