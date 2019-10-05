require "test_helper"

#two types of testing: 1. does the path work, 2. does the method work

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
      #changed below to assert_nil at the insistence of minitest 
      assert_nil(new_task.completed)
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
      get edit_task_path("394857")
      must_respond_with :redirect
      must_redirect_to tasks_path
      # Your code here
      end
    end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do 
      @task_2 = Task.create(name: "original name", description: "original description", completed: nil)
    end 
    it "can update an existing task" do
      updated_task_hash = {
        task: {
          name: "updated name",
          description: "updated description",
          completed: nil,
        },
      }
      
      expect { 
        patch task_path(@task_2.id), params: updated_task_hash
      }.wont_change 'Task.count'
      
      @task_2.reload 
      
      expect(@task_2.name).must_equal updated_task_hash[:task][:name]
      expect(@task_2.description).must_equal updated_task_hash[:task][:description]

      #add redirect to tasks path 
    end 
    
    
    it "will redirect to the root page if given an invalid id" do
      patch task_path(959685)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    before do 
      @this_task_is_toast = Task.create(name: "goodbye", description: "so long", completed: nil)
    end 

    it "can destroy a task" do 
      expect { 
        delete task_path(@this_task_is_toast.id)
      }.must_change 'Task.count' 
      must_respond_with :redirect 

    get task_path(@this_task_is_toast.id)
    must_respond_with :redirect
    end 
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
