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
      expect(flash[:error]).must_equal "Could not find task with id: -1"
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
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    
    let (:changes_hash) {
      {
        task: {
          name: "changed task",
          description: "new task description"
        },
      }
    }
    
    it "can update an existing task" do
      existing_task = Task.create name: "sample task", description: "this is an example for a test",
      completion_date: nil
      
      expect {
        patch task_path(existing_task.id), params: changes_hash
      }.wont_change "Task.count"
      
      must_respond_with :redirect
      
      task = Task.find_by(id: existing_task.id)
      
      expect(task.name).must_equal changes_hash[:task][:name]
      expect(task.description).must_equal changes_hash[:task][:description]
      expect(task.completion_date).must_be_nil
    end
    
    it "will redirect to the root page if given an invalid id" do
      id = -1
      
      expect {
        patch task_path(id), params: changes_hash
      }.wont_change "Task.count"
      
      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy a model" do
      tbd_task = Task.create name: "task to be destroyed", description: "delete me please",
      completion_date: nil
      
      tbd_task.save
      id = tbd_task.id
      
      expect { delete task_path(id) }.must_change 'Task.count', -1
      
      tbd_task = Task.find_by(id: id)
      
      expect(tbd_task).must_be_nil
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    it "can toggle a task to complete" do
      incomplete_task = Task.create name: "mark as complete", description: "incomplete to complete",
      completion_date: nil
      
      expect {
        patch toggle_complete_path(incomplete_task.id)
      }.wont_change "Task.count"
      
      current_task = Task.find_by(id: incomplete_task.id)
      
      expect(current_task.completion_date).wont_equal nil
    end
    
    it "can toggle a completed task to nil" do
      completed_task = Task.create name: "mark as incomplete", description: "complete to incomplete",
      completion_date: Time.now
      
      expect {
        patch toggle_complete_path(completed_task.id)
      }.wont_change "Task.count"
      
      current_task = Task.find_by(id: completed_task.id)
      
      expect(current_task.completion_date).must_be_nil
    end
  end
end
