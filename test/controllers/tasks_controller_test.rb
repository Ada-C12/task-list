require "test_helper"
require 'pry'

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

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      #Act
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
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    before do
      Task.create(name: "NOT washing my hair", description: "SLEEK HAIR", completion_date: nil)
    end

    let (:new_task_hash) {
      {
        task: {
          name: "A wrinkle in time",
          description: "a fabulous adventure",
          completion_date: (Time.now)
        }
      }
    }

    it "can update an existing task" do
      id = Task.first.id
      expect {
        patch task_path(id), params: new_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect

      task = Task.find_by(id: id)
      expect(task.name).must_equal new_task_hash[:task][:name]
      expect(task.description).must_equal new_task_hash[:task][:description]
      expect(task.completion_date).wont_be_nil
    end

    it "will redirect to the root page if given an invalid id" do
      # Act
      patch task_path(-1)

      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "successfully deletes an existing Task and then redirects to home page" do
      new_task_to_destroy = Task.create(name: "valid task", description: "this is a valid description")
      

      expect {
        delete task_path( new_task_to_destroy.id )
      }.must_differ "Task.count", -1

      must_redirect_to root_path
    end

    it "redirects to tasks index page and deletes no books if no books exist" do
      Task.destroy_all
      invalid_task_id = 1

      expect {
        delete task_path( invalid_task_id )
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
    end

    it "redirects to tasks index page and delets no tasks if deleting a task with an id that has already been deleted" do
      new_task = Task.create(name: "task name", description: "task description here")
      Task.destroy_all

      expect {
        delete task_path ( new_task.id )
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
    end

  end

  # # Complete for Wave 4
  # describe "toggle_complete" do
  #   # Your tests go here
  # end
end