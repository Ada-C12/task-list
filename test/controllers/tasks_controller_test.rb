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
      }.must_differ "Task.count", 1
      
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
      must_redirect_to '/tasks'
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    before do
      Task.create(name: "Laundry", description: "drop off at John Doe LLC", completed: nil)
    end
    
    updated_task_hash = {
      task: {
        name: "Dry cleaning",
        description: "drop off at Jane Doe LLC",
        completed: nil
      },
    }
    
    it "can update an existing task" do
      # Your code here
      id = Task.first.id
      expect {
        patch task_path(id), params: updated_task_hash
      }.wont_change "Task.count"
      
      must_respond_with :redirect
      
      updated_task = Task.find_by(id: id)
      expect(updated_task.name).must_equal "Dry cleaning"
      expect(updated_task.description).must_equal "drop off at Jane Doe LLC"
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      
      expect {
        patch task_path(id), params: updated_task_hash
      }.wont_change "Task.count"
      
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "won't update if the params are invalid" do
      id = Task.first.id
      unchanged_task = Task.find_by(id: id)
          
      expect {
        patch task_path(id), params: {}
      }.must_raise
          
      updated_task = Task.find_by(id: id)
      expect(updated_task.name).must_equal unchanged_task.name
      expect(updated_task.description).must_equal unchanged_task.description
      expect(updated_task.completed).must_equal unchanged_task.completed
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "will delete an existing task" do
      Task.create(name: "Meal Prep", description: "Egg salad sandwiches", completed: nil)
      existing_task_id = Task.find_by(name: "Meal Prep").id

      expect {
        delete task_path( existing_task_id )
      }.must_differ "Task.count", -1

      must_redirect_to root_path
      
    end
    
    it "will redirect if deleting non-existant task" do
      Task.destroy_all
      invalid_task_id = 1

      expect {
        delete task_path( invalid_task_id )
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
      
    end
    
    it "will redirect if deleting the same task twice" do
      Task.create(name: "Meal Prep", description: "Egg salad sandwiches", completed: nil)
      task_id = Task.find_by(name: "Meal Prep").id
      Task.destroy_all

      expect {
        delete task_path( task_id )
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
      
    end
  end
  
  # Complete for Wave 4
  describe "complete" do
    before do
      Task.create(name: "Laundry", description: "drop off at John Doe LLC", completed: nil)
    end
    
    completed_task_hash = {
      task: {
        name: "Dry cleaning",
        description: "drop off at Jane Doe LLC",
        completed: nil
      },
    }
    # Your tests go here
    it "will mark task as completed by filling in completed column" do
      id = Task.first.id
      expect {
        patch completed_task_path(id), params: completed_task_hash
      }.wont_change "Task.count"
      
      must_respond_with :redirect
      
      completed_task = Task.find_by(id: id)
      expect(completed_task.completed).wont_equal nil
    end

    it "will put nil in completed column if user mark a completed tast as not completed" do
      id = Task.first.id
      expect {
        patch completed_task_path(id), params: completed_task_hash
      }.wont_change "Task.count"
      expect {
        patch completed_task_path(id), params: completed_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect
      
      completed_task = Task.find_by(id: id)
      expect(completed_task.completed).must_equal nil

    end
  end
end
