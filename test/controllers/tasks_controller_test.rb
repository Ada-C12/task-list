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
      expect(flash[:error]).must_equal "Could not find task with id: -1"
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
      get edit_task_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    before do
      @updated_task = task
      @task_hash = {
        task: {
          name: @updated_task.name,
          description: "updated description",
          completion_date: @updated_task.completion_date
        }
      }
    end
    
    it "can update an existing task" do
      id = @updated_task.id
      
      expect {
        patch task_path(id), params: @task_hash
      }.wont_change "Task.count"
      
      @updated_task.reload
      
      expect(@updated_task.description).must_equal "updated description"
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch task_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "will delete a task" do
      
      new_task = Task.create(name: "sample task", description: "this is an example for a test", completion_date: Time.now + 5.days)
      
      expect {
        delete task_path(new_task.id)
      }.must_differ "Task.count", -1
    end
    
    it "will redirect to the root page if given an invalid id" do
      id = "bad-id"
      
      delete task_path(id)
      
      must_redirect_to root_path
    end
    
    it "will only delete a task once" do
      new_task = Task.create(name: "sample task", description: "this is an example for a test", completion_date: Time.now + 5.days)
      
      expect {
        delete task_path(new_task.id)
      }.must_differ "Task.count", -1
      
      expect {
        delete task_path(new_task.id)
      }.must_differ "Task.count", 0
      
      must_redirect_to root_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    before do
      @new_task = Task.create(name: "sample task", description: "this is an example for a test", completion_date: nil)
    end
    
    it "marks a task as completed by updating the completion date" do
      expect {
        patch complete_task_path(@new_task.id)
      }.must_differ "Task.count", 0
      
      @new_task.reload
      
      expect(@new_task.completion_date).must_equal Date.today 
    end
    
    
    it "marks a task as incompleted by updating the completion date to nil" do     
      patch complete_task_path(@new_task.id) # sets completion_date to Date.today
      expect {
        patch complete_task_path(@new_task.id) # sets completion_date to nil
      }.must_differ "Task.count", 0
      
      @new_task.reload
      
      expect(@new_task.completion_date).must_equal nil      
    end
    
    
    it "redirects to the task page when toggled" do
      patch complete_task_path(@new_task.id)
      
      must_redirect_to root_path
    end
  end
  
  describe "Strong Params" do
    # Michaela's strong params test
    it "won't update if the params are invalid" do
      unchanged_task = task
      
      expect {
        patch task_path(unchanged_task.id), params: {}
      }.must_raise
      
      updated_task = Task.find_by(id: unchanged_task.id)
      expect(updated_task.name).must_equal unchanged_task.name
      expect(updated_task.description).must_equal unchanged_task.description
      expect(updated_task.completion_date).must_equal unchanged_task.completion_date
    end
  end
  
end
