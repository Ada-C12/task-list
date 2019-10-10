require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    date: Time.now + 5.days
  }
  
  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      #get tasks_path
      get "/tasks"
      
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
          date: nil,
        },
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      #expect(new_task.due_date.to_time.to_i).must_equal task_hash[:task][:due_date].to_i
      expect(new_task.date).must_equal task_hash[:task][:date]
      #expect(new_task.date).assert_nil
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Unskip and complete these tests for Wave 3
  
  describe "edit" do
    it "can get the edit page for an existing task" do
      #skip
      
      # Act
      get edit_task_path(task.id)
      
      # Assert
      must_respond_with :success
      
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      # Your code here
      get edit_task_path(-1) 
      
      must_redirect_to root_path
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "can update an existing task" do
      # Your code here
      existing_task = Task.create(name: "new", description: "something")
      update_task_form_data = {
        task:{
          name: "Cleaning",
          description: "Cleaning Home",
          date: "10-04-2019"
        }
      }
      #Act
      patch task_path(existing_task.id, params: update_task_form_data)
      must_redirect_to root_path
      
      #Assert
      expect( Task.find_by(id: existing_task.id).name ).must_equal "Cleaning"
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
      # Arrange
      # Make the invalid id
      invalid_id = "whatever!"
      update_task_form_data = {
        task:{
          name: "Cleaning",
          description: "Cleaning Home",
          date: "10-04-2019"
        }
      }
      
      # get task_path sends a get request that will go to tasks controller show action
      # get task_path(:id)
      # if we want to do tasks controller update action, we need to send a patch request to the task_path
      # How do we do the form data in the tests? In our tests, we will do this syntax:
      patch task_path( invalid_id, params: update_task_form_data )
      # Assert
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
   # Complete these tests for Wave 4
    describe "destroy" do
    # Your tests go here
    it "can delete an existing task" do
      # Your code here
      existing_task = Task.create(name: "new", description: "something")
  
      #Act
      delete task_path(existing_task.id)
      must_redirect_to root_path
      
      #Assert
      expect( Task.find_by(id: existing_task.id) ).must_be_nil
    end
  
 end
  
   # Complete for Wave 4
   describe "toggle_complete" do
   # Your tests go here
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "can mark tasks as completed " do
      # Your code here
      existing_task = Task.create(name: "new", description: "something")
      update_task_form_data = {
        task:{
          name: "Cleaning",
          description: "Cleaning Home",
          date: "10-04-2019"
        }
      }
      #Act
      patch task_path(existing_task.id, params: update_task_form_data)
      must_redirect_to root_path
      
      #Assert
      expect( Task.find_by(id: existing_task.id).date).wont_equal nil
    end
  end
end