require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed: Time.now + 5.days
  }
  
  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      get "/tasks"
      must_respond_with :success
    end
    
    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end
  
  # Unskip these tests for Wave 2
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
      must_redirect_to tasks_path
    end
  end
  
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_respond_with :redirect
    end
  end
  
  
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      
      task_hash = {
        task: {
          name: "updated task",
          description: "update new task description"
        }
      }
      
      patch update_task_path(task), params: task_hash
      
      updated_task = Task.find_by(id: task.id)
      expect(updated_task.description).must_equal task_hash[:task][:description]
      expect(updated_task.name).must_equal task_hash[:task][:name]
      
      must_respond_with :redirect
      must_redirect_to task_path(task)
    end
    
    it "will redirect to the root page if given an invalid id" do
      task_hash = {
        task: {
          name: "updated task",
          description: "update new task description"
        }
      }
      patch update_task_path(-1), params: task_hash
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "should delete a task when prompted to" do
      count = Task.count
      new_task = Task.create name: "sample task", description: "this is an example for a test",
      completed: Time.now + 5.days
      
      # make sure that the new task is created 
      expect(Task.count).must_equal (count + 1)
      
      # make sure that when you delete the task, that the count of the Tasks database decreases by 1
      expect{
        delete task_path(new_task.id)
      }.must_change "Task.count", 1
      must_redirect_to root_path 
    end
    
    it "will redirect to the root page if given an invalid id" do
      task_hash = {
        task: {
          name: "updated task",
          description: "update new task description"
        }
      }
      delete task_path(-1), params: task_hash
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    let (:task) {
      Task.create name: "sample task", description: "this is an example for a test",
      completed: nil
    }
    
    it "can toggle_complete a task (populate :completed with Time.now)" do
      expect(task.completed).must_equal nil
      patch toggle_complete_path(task)
      
      must_respond_with :redirect
      must_redirect_to root_path
      
      testing_task_id = task[:id]
      completed_task = Task.find_by(id: testing_task_id)
      
      expect(completed_task[:completed]).must_be_instance_of ActiveSupport::TimeWithZone
      
    end
    it "will redirect to the root page if given an invalid id" do
      
      patch toggle_complete_path(-1)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  
  describe "toggle_incomplete" do
    let (:task) {
      Task.create name: "sample task", description: "this is an example for a test",
      completed: Time.new
    }
    
    it "can toggle_incomplete a task (populate :completed with Time.now)" do
      expect(task.completed).must_be_instance_of ActiveSupport::TimeWithZone
      patch toggle_incomplete_path(task)
      
      must_respond_with :redirect
      must_redirect_to root_path
      
      testing_task_id = task[:id]
      completed_task = Task.find_by(id: testing_task_id)
      
      expect(completed_task[:completed]).must_equal nil
      
    end
    it "will redirect to the root page if given an invalid id" do
      
      patch toggle_incomplete_path(-1)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
