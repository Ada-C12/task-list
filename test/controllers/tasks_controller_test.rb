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
      must_respond_with :not_found
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
    before do
      @new_task = Task.create(name: "make beds")
    end
    it "can update an existing task and redirects to that task's show page" do
      existing_task = Task.first
      task_hash_with_new_data = {
        task: {
          name: "edited task",
          description: "edited task description",
        },
      }
      expect {
        patch task_path(existing_task.id), params: task_hash_with_new_data
      }.wont_change "Task.count"
      expect(Task.find_by(id: existing_task.id).name).must_equal "edited task"
      expect(Task.find_by(id: existing_task.id).description).must_equal "edited task description"
      must_redirect_to task_path
    end
  end

  it "will respond with redirect when attempting to edit a nonexistent task" do
    must_respond_with :redirect
    # Your code here
  end
end

# Uncomment and complete these tests for Wave 3
describe "update" do
  # Note:  If there was a way to fail to save the changes to a task, that would be a great
  #        thing to test.
  let (:new_task_hash) {
    {
      task: {
        name: "sweep front steps",
        description: "compost leaves",
        completion_date: nil
      },
    }
  }


  it "will redirect to the root page if given an invalid id" do
    # Your code here
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
