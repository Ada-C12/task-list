require "test_helper"

describe TasksController do
  let (:task) do
    Task.create name: "sample task", description: "this is an example for a test",
    completion_date: Time.now + 5.days
  end
  
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
      task_hash = {task: { name: "new task", description: "new task description", completion_date: nil}}
      
      # Act-Assert
      expect {post tasks_path, params: task_hash}.must_change "Task.count", 1
      
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
      #Act
      edit_task = Task.create(name: "dishes", description: "run dishwasher")
      get edit_task_path(edit_task)
      
      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #Act
      get edit_task_path(1337)
      
      #Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      update_task = Task.create(name: "play with the cat", description: "mouse")
      
      # Arrange
      updated_task_test = {task: {name: "play with the cat", description: "buy new cat toys"}}
      
      # Act
      patch task_path(update_task), params: updated_task_test
      
      #Assert 
      update_task.reload
      expect(update_task.description).must_equal updated_task_test[:task][:description]
    end
    
    it "will redirect to the root page if given an invalid id" do
      bad_id = {task: {name: "bake", description: "chocolate chip cookies"}}
      
      patch task_path(45743895), params: bad_id
      
      #Arrange
      must_respond_with :redirect
      must_redirect_to tasks_path 
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "can delete a task" do 
      remove_task = Task.create(name: "watch lectures", description: "panopto")
      task_count = Task.count
      
      #Act
      delete task_path(remove_task)
      
      #Assert
      expect(Task.count).must_equal (task_count - 1)
    end
    
    it "gives a 404 error when invalid " do 
      delete task_path(4756437657384658345)
      must_respond_with :not_found
    end
    
  end
  
  describe "toggle_complete" do
    it "can complete a task" do 
      
      #Arrange
      task_one = Task.create(name: "cs fun", description: "complete recursion homework")
      
      
      #Act
      patch completed_path(task_one.id)
      task_one.reload
      
      #Assert
      expect(task_one.completion_date).wont_be_nil
    end
    
    it "gives a 404 error when invalid" do 
      patch completed_path(357283582365382657823)
      must_respond_with :not_found
    end
  end
end
