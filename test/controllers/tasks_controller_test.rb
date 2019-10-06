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
      expect(new_task.completed).must_equal task_hash[:task][:completed]

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
      # Act
      get edit_task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      # Your code here
      existing_task = Task.create(name: "task_90", description: "prepare my lunch", completed: nil)
      updated_task_form_data = {
        task: {
          name: "task_80",
          description: "prepare my lunch",
          completed: nil,
        }
      }
      
      patch task_path(existing_task.id), params: updated_task_form_data

      expect(Task.find_by(id: existing_task.id).name).must_equal "task_80"
    end

    it "can't update an existing task giving wrong parameters" do
      # Your code here
      existing_task = Task.create(name: "task_100", description: "clean the house", completed: nil)
      updated_task_form_data = {
        task: {
          names: "task_70",
          description: "clean the house",
          completed: nil,
        }
      }
      
      patch task_path(existing_task.id), params: updated_task_form_data

      expect(Task.find_by(id: existing_task.id).name).must_equal nil
    end

    it "will redirect to the root page if given an invalid id" do
      # Act
      patch task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can delete a task" do
      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed: nil
        }
      }

      old_task = Task.create(task_hash[:task])

      # Act-Assert
      expect {
        delete task_path(old_task.id)
      }.must_change "Task.count", 1

    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "can mark a task as completed" do
      # Your tests go here
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed: nil
        }
      }

      gmsb_task = Task.create(task_hash[:task])

        patch complete_task_path(gmsb_task.id)

      expect(Task.find_by(id: gmsb_task.id).completed).wont_equal nil
    end

  end
end
