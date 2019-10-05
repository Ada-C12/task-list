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
      
      #changed "due date" to "completion date" label in the test to match the schema column label. 
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  # I Interpret this to be the form coming up to ENTER the information that's going to be edited. 
  # Tests are borrowed from 
  describe "edit" do
    it "can get the edit page for an existing task" do
      #Act
      get edit_task_path(task.id)
      
      #Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #Act
      get edit_task_path(-1)
      
      #Assert
      must_respond with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  # I interpret this as POSTING  
  # Tests borrowed from create
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    
    # This creates a task that will be edited
    before do
      new_task = Task.new
      new_task.name = "ln 115 sample task"
      new_task.description = "this is an example for a test"
      new_task.completion_date = Time.now + 5.days
      new_task.save
      
    end
    
    it "can update an existing task and total number of tasks is unaffected" do
      #Arrange
      revising_task_description = "edited new task"
      
      #Expect
      # new_task = Task.find_by(name:"ln 115 sample task")
      test_task = Task.find_by(name:"ln 115 sample task")
      test_task.description = revising_task_description

      
      #Assert
      expect { patch test_task
      }.must_change "Task.count", 0

      expect(Task.find_by(name:"ln 115 sample task").description).must_equal revising_task_description

      
    end
    
    it "will redirect to the root page if given an invalid id" do
      #Act
      get edit_task_path(-1)
      
      #Assert
      must_respond_with :redirect
    end

  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
