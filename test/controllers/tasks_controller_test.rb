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
      expect(flash[:error]).must_equal "Could not find task with id: -1"
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
      
      get edit_task_path(task.id)
      
      must_respond_with :success
      
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
      
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
          description: @updated_task.description,
          completion_date: @updated_task.completion_date
        }
      }
    end
    
    it "can update an existing task" do
      
      id = @updated_task.id
      
      expect {
        patch task_path(id), params: @task_hash
      }.wont_change "Task.count"
      
    end
    
    it "will redirect to the root page if given an invalid id" do
      
      #it's working now!
      
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
    # Your tests go here
    
    before do
      @new_task = Task.create(name: "sample task", description: "this is an example for a test", completion_date: nil)
      
      @id = @new_task.id
      
      @task_updates = { 
        task: {
          name: @new_task.name,
          description: @new_task.description,
          completion_date: Date.today 
        }
      }
      
    end
    
    it "marks a task as completed by updating the completion date" do
      
      
      puts "before anything"
      puts @new_task.name
      puts @new_task.completion_date
      puts @new_task.id
      puts @id
      
      patch complete_task_path(@new_task.id)
      
      @new_task.reload
      
      puts "before expect"
      puts @new_task.name
      puts @new_task.completion_date
      puts @new_task.id
      puts @id
      
      puts task.name
      puts task.completion_date
      
      expect {
        patch complete_task_path(@id), params: @task_updates
      }.must_differ "Task.count", 0
      
      
      puts "after expect"
      puts @new_task.name
      puts @new_task.completion_date
      puts task.name
      puts task.completion_date
      
      expect(@new_task.completion_date).must_equal Date.today
      
    end
    
    it "renders the task page when completed" do
      
      
    end
    
    
  end
end
