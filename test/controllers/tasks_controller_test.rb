require "test_helper"
# require_relative "../../app/controllers/concerns/tasks_controller"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completion_date: Time.now + 5.days
  }

  # Tests for Wave 1
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

  # Tests for Wave 2
  describe "show" do
    it "can get a valid task" do
      get task_path(task.id)
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get edit_task_path(-1)
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
          completion_date: nil,
        },
      }
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

  # Tests for Wave 3
  describe "update" do
        # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    before do
      @new_task = Task.create(name: "make beds")
      @task_hash_with_new_data = {
        task: {
          name: "edited task",
          description: "edited task description",
        },
      }
    end
    it "can update an existing task and redirects to that task's show page" do
      existing_task = Task.first
      expect {
        patch task_path(existing_task.id), params: @task_hash_with_new_data
      }.wont_change "Task.count"
      expect(Task.find_by(id: existing_task.id).name).must_equal "edited task"
      expect(Task.find_by(id: existing_task.id).description).must_equal "edited task description"
      must_redirect_to task_path
    end

    it "will respond with redirect when attempting to edit a nonexistent task" do
      patch task_path(5), params: @task_hash_with_new_data
      must_respond_with :redirect
    end
  end

  # Tests for Wave 4
  describe "destroy" do
    it 'decreases Task count by one after deletion' do
      task = Task.create(name: "take out compost")
      old = Task.count
      delete task_path(task.id)
      expect(Task.count).must_equal (old - 1)
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it 'goes from nil to the current date' do
      task = Task.create(name: "take out compost")
      put toggle_complete_path(task.id)
      expect(Task.find_by(id: task.id).completion_date).must_equal Date.today
    end

    it 'goes from the current date to nil' do
      task = Task.create(name: "take out compost")
      put toggle_complete_path(task.id)
      put toggle_complete_path(task.id)
      expect(Task.find_by(id: task.id).completion_date).must_equal nil
    end
  end
end
