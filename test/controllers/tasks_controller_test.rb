require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: Time.now + 5.days
  }

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

  describe "edit" do
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do

      # Act
      get task_path(id: 150)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing task" do
      # Arrange
      task_hash = {
        task: {
          name: "updated task",
          description: " update new task description",
          completed: nil,
        },
      }

      # Act-Assert
      # task_hash info is being sent to server and stored in params via the patch request
      patch task_path(id: task.id), params: task_hash

      # finding it in the database and assigning it to new variable
      updated_task = Task.find_by(id: task.id)

      expect(updated_task.description).must_equal task_hash[:task][:description]
      expect(updated_task.name).must_equal task_hash[:task][:name]
    end

    it "will redirect to the root page if given an invalid id" do
      patch task_path(id: 100)

      must_respond_with :redirect 
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "will delete a task from the database" do

      task

      expect {
        delete task_path(id: task.id) 
      }.must_differ 'Task.count', -1
    end 

    it "will redirect to the root page once a task is destroyed" do
      # Act
      task 

      delete task_path(task.id)

      # Assert
      must_respond_with :redirect
    end 

    it "will respond with an error if invalid id is given" do
      delete task_path('150')

      must_respond_with :not_found
    end 
  end 

  
  # Complete for Wave 4
  describe "toggle_complete" do
    it "updates the completed field of a Task instance " do
      # Act
      task

      patch complete_task_path(task.id)

      updated_task = Task.find_by(id: task.id)

      expect(updated_task.completed).must_equal nil
      must_respond_with :redirect
      must_redirect_to tasks_path
    end 

    it "will respond with an error if invalid id is given" do
      patch complete_task_path('150')

      must_respond_with :not_found
    end 
  end
end

