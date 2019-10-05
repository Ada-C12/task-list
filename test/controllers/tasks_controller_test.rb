require "test_helper"

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
      # In the tests we need to arrange and set up the form data
      # For each test that will have form data, we need to add something that looks like the form data in params.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
        },
      }
      
      # Sends the form data task_hash into params
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
      get edit_task_path(task.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    before do
      @new_task = Task.create(name: "new task")
    end
    
    it "can update an existing task" do
      # sets up the form data to what the task will be updated to
      existing_task = Task.first
      
      updated_task_form_data = {
        task: {
          name: "updated task",
          description: "updated task description",
          completion_date: nil,
        },
      }
      
      # updates the task data, send the updated form to params
      # checks if update is not going to change the task count
      expect {
        patch task_path(existing_task.id), params: updated_task_form_data
      }.wont_change "Task.count"
      
      expect(Task.find_by(id: existing_task.id).name).must_equal "updated task"
      expect(Task.find_by(id: existing_task.id).description).must_equal "updated task description"
      expect(Task.find_by(id: existing_task.id).completion_date).must_equal nil 
    end
    
    it "will redirect to the root page if given an invalid id" do
      get task_path(-1)
      must_respond_with :redirect
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    before do
      @new_task = Task.create(name: "new task")
    end
    
    it "can delete an existing task" do
      existing_task = Task.last
      
      expect {
        delete task_path(existing_task.id)
      }.must_change "Task.count", -1
    end
    
    it "will redirect to the root page if given an invalid id" do
      get task_path(-1)
      must_respond_with :redirect
    end
  end 
  
  describe "toggle_complete" do   
    before do
      @new_task = Task.create(name: "completed task", completion_date: nil )
    end
    
    it "changes completion date from nil to today's date when clicked" do 
      existing_task = Task.last
      
      completed_task_form_data = {
        task: {
          name: "completed task",
          description: "completed description",
          completion_date: DateTime.now.to_date,
        },
      }      
      
      expect {
        post complete_task_path(existing_task.id)
      }.wont_change "Task.count"
      
      expect(Task.find_by(id: existing_task.id).name).must_equal "completed task"
      expect(Task.find_by(id: existing_task.id).completion_date).must_equal completed_task_form_data[:task][:completion_date]
    end
  end
end
