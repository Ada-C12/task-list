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

  # Wave 2
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
      assert_nil(new_task.completed)

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Act
      get edit_task_path(-1)

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      # Arrange
      existing_task = Task.create(name: "crochet lobster", description: "mainly just need to finish up them arms!")
      update_params = {
        task: {
          name: "rock lobster",
          description: "make a lobster out of rock, instead!"
        }
      }

      # Act/Assert
      expect{patch task_path(existing_task.id), params: update_params}.must_differ "Task.count", 0

      # Assert
      expect(Task.find_by(id: existing_task.id).name).must_equal "rock lobster"
    end



    it "will redirect to the root page if given an invalid id" do
      # Arrange
      existing_task = Task.create(name: "crochet lobster", description: "mainly just need to finish up them arms!")
      update_params = {
        task: {
          name: "rock lobster",
          description: "make a lobster out of rock, instead!"
        }
      }

      # Act
      patch task_path(-1), params: update_params 

      # Assert
      must_respond_with :redirect  
      must_redirect_to root_url
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "lowers the number of Tasks by 1 when valid id is given and redirects to tasks path" do
      # Arrange
      existing_task = Task.create(name: "crochet lobster", description: "mainly just need to finish up them arms!")
      # Act/Assert
      expect{delete task_path(existing_task.id)}.must_differ "Task.count", -1
      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "won't delete the same thing twice and redirects to tasks path" do
      # Arrange
      existing_task = Task.create(name: "crochet lobster", description: "mainly just need to finish up them arms!")
      # Act/Assert
      # existing task id:
      test_id = existing_task.id
      # first delete
      expect{delete task_path(test_id)}.must_differ "Task.count", -1
      # second delete
      expect{delete task_path(test_id)}.must_differ "Task.count", 0
      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will not delete anything if given invalid id and will redirect to tasks path" do
      expect{delete task_path(-1)}.must_differ "Task.count", 0
      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "changes a new task's completed value to not nil and redirects to tasks path" do
      # Arrange
      new_task = Task.create(name: "crochet lobster", description: "mainly just need to finish up them arms!")
      update_params = {
        id: new_task.id
      }
      assert_nil new_task.completed
      # Act
      patch toggle_completed_path(new_task.id), params: update_params
      # Assert
      assert_not_nil Task.find_by(id: new_task.id).completed
      must_respond_with :found
      must_redirect_to tasks_path

    end
    it "changes a completed task's completed value back to nil and redirects to tasks path" do
      # Arrange
      completed_task = Task.create(name: "it's done!", description: "that was easy! .... ", completed: Time.now)
      update_params = {
        task: {
          completed: completed_task.completed
        }
      }
      # Act
      patch toggle_completed_path(completed_task.id), params: update_params
      # Assert
      assert_nil Task.find_by(id: completed_task.id).completed
      must_respond_with :found
      must_redirect_to tasks_path
    end

  end

end
