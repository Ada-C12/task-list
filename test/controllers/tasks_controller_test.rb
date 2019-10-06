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
      
      # 
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
          completion_date: nil,
        },
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      # expect(new_task.due_date.to_time.to_i).must_equal task_hash[:task][:due_date].to_i
      # expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]
      
      # must_respond_with :redirect
      # must_redirect_to task_path(new_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
        },
      }
      # Your code here
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
        },
      }
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      @new_task = Task.create(name: "Wash dishes")
    end
    
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      existing_task = Task.first
      updated_task_form_data = {
        task: {
          name: "Clean Windows",
          description: 'A look at how to design object-oriented systems',
          completion_date: nil
        }
      }
      
      expect {
        patch task_path(existing_task.id), params: updated_task_form_data
      }.wont_change 'Task.count'
      
      expect( Task.find_by(id: existing_task.id).name ).must_equal "Wash dishes"
      
    end
    
    it "will redirect to the root page if given an invalid id" do
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy an existing task" do
      # Your tests go it "can create a new task" do
      
      
      # Act-Assert
      expect {
        delete tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      # expect(new_task.due_date.to_time.to_i).must_equal task_hash[:task][:due_date].to_i
      # expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end 
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
