require "test_helper"
require "pry"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: Time.now + 5.days
  }

  # Wave 1
  describe "index" do
    it "can get the index path" do
      get tasks_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  # Wave 2
  describe "show" do
    it "can get a valid task" do
      get task_path(task.id)
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get task_path(-1)
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      get new_task_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed: nil,
        },
      }

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

  # Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success 
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(500)
      must_redirect_to root_path
    end
  end

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      existing_task = Task.first
      updated_task_data = {
        task: {
          name: "Feed Kaya",
          description: "She's a fatty. Feed half a cup a meal and lots of snacks -- don't forget 1 dental a day.",
          completed: nil
        }
      }
      
      expect {
        patch task_path(existing_task.id), params: updated_task_data
      }.must_change "Task.count", 0

      expect(existing_task.name).must_equal updated_task_data[:task][:name]
      expect(existing_task.description).must_equal updated_task_data[:task][:description]
      expect(existing_task.completed).must_equal updated_task_data[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(existing_task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      patch task_path(500)
      must_redirect_to root_path 
    end
  end

  # Wave 4
  describe "destroy" do
    # Your tests go here

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
