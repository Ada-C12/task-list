require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test", completion_date: Time.now + 5.days
  }
  
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
  
  describe "show" do
    it "can get a valid task" do
      get task_path(task.id)
      
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      get task_path(-1)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find task with id: -1"
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
      
      assert_nil(new_task.completion_date)
      
      must_respond_with :redirect
      
      must_redirect_to task_path(new_task)
    end
  end
  
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(id: -1)
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  describe "update" do
    it "can update an existing task" do
      existing_task = Task.create name: "test task", description: "task description", completion_date: Time.now
      
      updated_task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
        },
      }
      
      expect {
        patch task_path(existing_task.id), params: updated_task_hash
      }.wont_change 'Task.count'
      
      updated_task = Task.find_by(id: existing_task.id)
      
      expect(updated_task.name).must_equal updated_task_hash[:task][:name]
      expect(updated_task.description).must_equal updated_task_hash[:task][:description]
      
      must_respond_with :redirect
      must_redirect_to task_path(updated_task)
    end
    
    it "will redirect to the root page if given an invalid id" do
      updated_task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
        },
      }
      
      invalid_task_id = -1
      
      patch task_path(invalid_task_id), params: updated_task_hash
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
  describe "destroy" do
    it "will remove a task given a valid id" do
      new_task = Task.create name: "task to be deleted", description: "task description", completion_date: nil
      
      valid_id = new_task.id
      
      expect {
        delete task_path(valid_id)
      }.must_change "Task.count", -1
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
    it "will redirect to home when given invalid id" do
      invalid_id = -1
      
      delete task_path(invalid_id)
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
  end
  
  describe "toggle_complete" do
    it "marks an incomplete task as complete" do 
      incomplete_task = Task.create name: "incomplete_task", description: "task description", completion_date: nil, complete: false
      patch "/tasks/#{incomplete_task.id}/toggle"
      
      current_month = Time.now.month 
      current_day = Time.now.day
      
      must_respond_with :redirect
      must_redirect_to task_path(incomplete_task.id)
      
      newly_completed_task = Task.find_by(id: incomplete_task.id)
      expect(newly_completed_task.complete).must_equal true
      expect(newly_completed_task.completion_date.year).must_equal 2019
      expect(newly_completed_task.completion_date.month).must_equal current_month
      expect(newly_completed_task.completion_date.day).must_equal current_day
      
    end
    
    it "marks a complete task as incomplete" do 
      current_time = Time.now
      
      complete_task = Task.create name: "complete_task", description: "task description", completion_date: current_time, complete:true
      
      patch "/tasks/#{complete_task.id}/toggle"
      
      must_respond_with :redirect
      must_redirect_to task_path(complete_task.id)
      
      newly_incomplete_task = Task.find_by(id: complete_task.id)
      expect(newly_incomplete_task.complete).must_equal false
      assert_nil(newly_incomplete_task.completion_date)
    end
    
    it "redirects to home when given invalid id" do
      invalid_id = -1
      
      patch "/tasks/#{invalid_id}/toggle"
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
  
end



