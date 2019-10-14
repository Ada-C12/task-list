require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed: nil
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
  
  # Test for Wave 2: show
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
  
  # Test for Wave 2: new
  describe "new" do
    it "can get the new task page" do
      get new_task_path
      
      must_respond_with :success
    end
  end
  
  # Test for Wave 2: create
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
  
  # Tests for Wave 3: edit
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
  
  # Tests for Wave 3: update
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    before do
      @update_task = Task.create(name: "wash car", description: "rinse and wash", completed: nil)
      
      @updated_task_hash = {
        task: {
          name: "updated task",
          description: "updated task description",
          completed: nil,
        },
      }
    end
    
    it "can update an existing task" do
      expect {
        patch task_path(@update_task.id), params: @updated_task_hash
      }.wont_change "Task.count"
      
      must_respond_with :redirect
      
      updated_task = Task.find_by(id: @update_task.id)
      expect(updated_task.name).must_equal @updated_task_hash[:task][:name]
      expect(updated_task.description).must_equal @updated_task_hash[:task][:description]
      expect(updated_task.completed).must_equal @updated_task_hash[:task][:completed]
    end
    
    it "will redirect to the root page if given an invalid id" do
      expect {
        patch task_path(-1), params: @updated_task_hash
      }.wont_change "Task.count"
      
      must_respond_with :redirect
    end
  end
  
  # Tests for Wave 4: destroy
  describe "destroy" do
    before do
      @delete_task = Task.create(name: "wash car", description: "rinse and wash", completed: nil)
    end
    
    it "can delete an existing task" do
      expect {
        delete task_path(@delete_task.id)
      }.must_change "Task.count", -1
      
      find_task = Task.find_by(id: @delete_task.id)
      expect(find_task).must_equal nil
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
    it "will redirect to main page if given an invalid id" do
      expect{
        delete task_path(-1)
      }.wont_change "Task.count"
      
      must_respond_with :redirect
    end
  end
  
  # Tests for Wave 4: make_completed
  describe "make completed" do
    before do
      @not_completed_task = Task.create(name: "wash car", description: "rinse and wash", completed: nil)
    end
    
    it "can make a task that wasn't complete to completed" do
      expect {
        patch completed_task_path(@not_completed_task)
      }.wont_change "Task.count"
      
      find_task = Task.find_by(id: @not_completed_task)
      expect(find_task.completed).wont_equal nil
      
      must_respond_with :redirect
    end
  end
  
  # Tests for Wave 4: make_not_completed
  describe "make not completed" do
    before do
      @completed_task = Task.create(name: "wash car", description: "rinse and wash", completed: DateTime.now)
    end
    
    it "can make a task that was completed to not complete" do
      expect {
        patch not_completed_task_path(@completed_task)
      }.wont_change "Task.count"
      
      find_task = Task.find_by(id: @completed_task)
      expect(find_task.completed).must_equal nil
      
      must_respond_with :redirect
    end
  end
end