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
      #expect(flash[:error]).must_equal "Could not find task with id: -1"
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
      expect(new_task.completion_date).must_equal nil
      expect(new_task.name).must_equal task_hash[:task][:name]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      
      get edit_task_path(1)

      must_respond_with :found
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Task.create(name: "dishes", description: "wash dishes")
    end
    let (:new_task_hash) {
      {
        task: {
          name: "gardening",
          description: "mow the lawn"
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
      expect(task.completion_date).must_equal new_task_hash[:task][:completion_date]

    end

    it "will redirect to the root page if given an invalid id" do
      id = -1

      expect {
        patch task_path(id), params: new_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    
    it "deletes an existing task and redirects to the root page" do
    Task.create(name: "dishes", description: "wash dishes")
    existing_task_id = Task.find_by(name: "dishes").id

    expect {
      delete task_path( existing_task_id)
    }.must_differ "Task.count", -1

    must_redirect_to root_path
    end

    it "redirects to the index page if user attempts to delete an invalid task" do
    Task.destroy_all
    invalid_task_id = 1

    expect {
      delete task_path(invalid_task_id)
    }.must_differ "Task.count", 0

    must_redirect_to tasks_path
    end
  end

  describe "mark_complete" do

    it "can mark a task complete with the current time" do
      Task.create(name: "dishes", description: "wash dishes")
      existing_task_id = Task.find_by(name: "dishes").id

    expect {
      patch mark_complete_path(existing_task_id)
    }.wont_change "Task.count"

    task = Task.find_by(id: existing_task_id)
      expect(task.name).must_equal "dishes"
      expect(task.description).must_equal "wash dishes"
      expect(task.completion_date).must_be_instance_of ActiveSupport::TimeWithZone
    end
  end
end
