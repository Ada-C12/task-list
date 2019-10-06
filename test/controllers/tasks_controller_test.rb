require "test_helper"
require 'pry'

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test", completion_date: Time.now + 5.days
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
      expect(new_task.completion_date).must_be_nil task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # skip
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
      
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Your code here
      invalid_id = -500
      
      get edit_task_path(invalid_id)

      must_respond_with :redirect

      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "can update an existing task" do
      # skip
      updated_task_form_data = {
        task: {
          name: "another task",
          description: "another task description",
          completion_date: Time.now + 10.days
        }
      }

      patch task_path(task.id), params: updated_task_form_data

      updated_data = Task.find_by(id: task.id)

      expect(updated_data.name).must_equal updated_task_form_data[:task][:name] #"another task"
  
      must_respond_with  :redirect
      must_redirect_to task_path(updated_data.id)
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      invalid_id = -500
      
      patch task_path(invalid_id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "successfully deletes an existing Task and then redirects to home page" do
      Task.create(name: "A test task", description: "This is how you do it", completion_date: nil)
      existing_task_id = Task.find_by(name: "A test task").id

      expect {
        delete task_path( existing_task_id )
      }.must_differ "Task.count", -1

      must_redirect_to root_path
    end

    it "redirects to tasks index page and deletes no tasks if no tasks exist" do
      Task.destroy_all
      invalid_task_id = 1

      expect {
        delete task_path( invalid_task_id )
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
    end

    it "redirects to tasks index page and deletes no tasks if deleting a task with an id that has already been deleted" do
      Task.create(name: "A test task", description: "This is how you do it", completion_date: nil)
      task_id = Task.find_by(name: "A test task").id
      Task.destroy_all

      expect {
        delete task_path( task_id )
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "updates a task by changing completion_date from nil to a time object when a user clicks on the 'complete task' button" do
      # Your tests go here
      test_task = {
        task: {
          name: "A test task",
          description: "This is how you do it",
          completion_date: nil
        }
      }

      patch task_path(task.id), params: test_task

      updated_task = Task.find_by(id: task.id)

      updated_task = {
        task: {
          name: "A test task",
          description: "This is how you do it",
            completion_date: Time.now
        }
      }

      patch complete_task_path(task.id), params: updated_task

      task_with_time_stamp = Task.find_by(id: task.id)

      expect(task_with_time_stamp.completion_date).must_be_instance_of ActiveSupport::TimeWithZone

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "updates a task by changing completion_date from a time object to nil when a user clicks on the 'complete task' button" do
      # Your tests go here
      test_task = {
        task: {
          name: "A test task",
          description: "This is how you do it",
          completion_date: Time.now
        }
      }

      patch task_path(task.id), params: test_task

      updated_task = Task.find_by(id: task.id)

      updated_task = {
        task: {
          name: "A test task",
          description: "This is how you do it",
            completion_date: nil
        }
      }

      patch complete_task_path(task.id), params: updated_task

      task_with_time_stamp = Task.find_by(id: task.id)

      expect(task_with_time_stamp.completion_date).must_be_nil
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
end
