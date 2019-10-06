require "test_helper"
require "pry"
require "time"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: Time.now + 5.days
  }

  # Wave 1
  describe "index action" do
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
  describe "show action" do
    it "can get a valid task" do
      get task_path(task.id)
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get task_path(-1)
      must_respond_with :redirect
    end
  end

  describe "new action" do
    it "can get the new task page" do
      get new_task_path
      must_respond_with :success
    end
  end

  describe "create action" do
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
      expect(new_task.completed).must_be_nil task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Wave 3
  describe "edit action" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success 
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(500)
      must_redirect_to root_path
    end
  end

  describe "update action" do
    it "can update an existing task" do
      existing_task = Task.create(name:"Feed Kaya", description: "She's a fatty. Feed half a cup a meal and lots of snacks.")
      updated_task_data = {
        task: {
          name: "Feed Kaya",
          description: "She's a fatty. Feed half a cup a meal and lots of snacks -- don't forget 1 dental a day.",
          completed: nil
        }
      }

      patch task_path(existing_task.id), params: updated_task_data

      updated_task = Task.find_by(id: existing_task.id)
      expect(updated_task.name).must_equal updated_task_data[:task][:name]
      expect(updated_task.description).must_equal updated_task_data[:task][:description]
      expect(updated_task.completed).must_be_nil updated_task_data[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(updated_task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      patch task_path(500)
      must_redirect_to root_path 
    end
  end

  # Wave 4
  describe "destroy action" do
    it "successfully deletes an existing Task and then redirects to home page" do
      Task.create(name: "Cuddle with Kaya", description: "She hates cuddles but do it anyways hehehehehe", completed: nil)
      existing_task_id = Task.find_by(name: "Cuddle with Kaya").id

      expect {
        delete task_path(existing_task_id)
      }.must_differ "Task.count", -1

      must_redirect_to root_path
    end

    it "redirects to tasks index page and doesn't delete any tasks if no tasks exist" do
      Task.destroy_all
      invalid_id = 1

      expect {
        delete task_path(invalid_id)
      }.must_differ "Task.count", 0

      must_redirect_to root_path
    end

    it "redirects to tasks index page if selected task has already been deleted and doesn't delete any other tasks" do
      my_task = Task.create(name: "Cuddle with Kaya", description: "She hates cuddles but do it anyways hehehehehe", completed: nil)
      
      Task.destroy_all

      expect {
        delete task_path(my_task.id)
      }.must_differ "Task.count", 0

      must_redirect_to root_path
    end

  end

  describe "completed action" do
    it "should be marked with today's date for attribute completed and redirects to root_path" do
      my_task = Task.create(name: "Cuddle with Kaya", description: "She hates cuddles but do it anyways hehehehehe", completed: nil)

      updated_task_data = {
        task: {
          completed: Time.now
        }
      }

      patch completed_task_path(my_task.id), params: updated_task_data

      completed_task = Task.find_by(id:my_task.id)
      
      expect(completed_task.completed).must_be_kind_of Time 
      must_redirect_to root_path
    end 
  end
end
