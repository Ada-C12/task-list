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
      #Act
      get edit_task_path(task.id)
      
      #Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
      # Act
      get edit_task_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      @original_task = Task.create name: "test name", description: "test description"
      @updated_task = {
        task: {
          name: "test name",
          description: "updated description",
          completion_date: nil,
        },
      }
    end
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      expect { patch task_path(@original_task.id), params: @updated_task }.wont_change "Task.count"
      
      update_task = Task.find_by(id: @original_task.id)
      expect(update_task.description).must_equal "updated description"
      expect(update_task.name).must_equal "test name"
      assert_nil (update_task.completion_date)
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch task_path(-1), params: @updated_task
      
      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    before do
      @another_task = Task.create name: "test name", description: "test description"
    end
    
    it "can remove an existing task" do
      assert_difference('Task.count', -1, 'A task should be deleted' ) do 
        delete task_path(@another_task.id)
      end
      
      assert_nil Task.find_by(name: "test name")
    end
    
    it "will redirect to the root page if given an invalid id" do
      delete task_path(-1)
      
      must_redirect_to root_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    before do
      @task2 = Task.create name: "test name", description: "test description"
    end
    
    it "Can update a task from nil to completed and vice versa" do
      expect { patch completed_path(@task2.id) }.wont_change "Task.count"
      
      complete_task = Task.find_by(id: @task2.id)
      assert_kind_of Time, complete_task.completion_date
      
      # toggle completion to nil
      patch completed_path(@task2.id)
      complete_task.reload
      assert_kind_of NilClass, complete_task.completion_date
    end
  end
end
