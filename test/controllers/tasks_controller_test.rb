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

  # Tests for Wave 2
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
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Tests for Wave 3
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
    task_hash = {
      task: {
        name: "updated task",
        description: "updated task description"
      },
    }

    it "can update an existing task" do
      expect {
        patch task_path(task.id), params: task_hash
      }.must_change "Task.count", 0

      updated_task = Task.find_by(name: task_hash[:task][:name])
      expect(updated_task.description).must_equal task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to task_path(task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch task_path(99999), params: task_hash
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Tests for Wave 4
  describe "destroy" do
    
    it "can delete an exisiting task" do
      @testing_task = Task.create(
        name: "testing task",
        description: "testing task description"
      )
      
      expect {
        delete task_path(@testing_task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "will redirect to rooth path when given an invalid id" do 
      delete task_path(-1)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end 
  end

  # describe "toggle_complete" do
  #   # Your tests go here
  # end
end