require "test_helper"

describe TasksController do
  let (:task) {
    tasks(:task)
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
  
  # Tests for Wave 2
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
          completed: nil,
        },
      }
      
      # Act-Assert
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
  
  # Tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "update" do
    it "can update an existing task" do
      task_hash = { task: { name: "Updated task", description: "Updated task description", completed: nil }}
      
      patch task_path(task.id), params: task_hash
      
      updated_task = Task.find_by(id: task.id)
      
      expect(updated_task.name).must_equal task_hash[:task][:name]
      expect(updated_task.description).must_equal task_hash[:task][:description]
      expect(updated_task.completed).must_equal task_hash[:task][:completed]
      
      must_respond_with :redirect
      must_redirect_to task_path
    end
    
    it "will redirect to the root page if given an invalid id" do
      task_hash = {
        task: {
          name: "Updated task",
          description: "Updated task description",
          completed: nil,
        },
      }
      
      patch task_path(-1), params: task_hash
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Tests for Wave 4
  describe "destroy" do
    it "will reduce the total task count by 1" do
      id_to_delete = task.id
      
      expect {
        delete task_path(id_to_delete)
      }.must_differ "Task.count", -1
      
      must_redirect_to tasks_path
    end
    
    it "will remove the deleted task from the database" do
      id_to_delete = task.id
      delete task_path(id_to_delete)
      
      removed_task = Task.find_by(id: task.id)
      
      removed_task.must_be_nil
      must_redirect_to tasks_path
    end
    
    it "will redirect to root path if record does not exist" do
      nonexistent_id = -1
      
      expect {
        delete task_path(nonexistent_id)
      }.must_differ "Task.count", 0
      
      must_redirect_to tasks_path
    end
    
    it "will redirect to task index page if task was already deleted" do
      id_to_delete = task.id
      Task.destroy_all
      
      expect {
        delete task_path(id_to_delete)
      }.must_differ "Task.count", 0
      
      must_redirect_to tasks_path
    end
  end
  
  describe "toggle_complete" do
    it "will change a task from not completed to completed with DateTime object" do
      incomplete_task = Task.create(name: "An incomplete task", description: "Yes, oh so incomplete", completed: nil)
      
      patch toggle_complete_path(incomplete_task.id)
      
      completed_task = Task.find_by(name: "An incomplete task")
      
      expect(completed_task.completed).must_be_kind_of ActiveSupport::TimeWithZone
      expect(completed_task.completed).must_be_close_to Time.now, 0.05
    end
    
    it "will change a task from completed with DateTime object to not completed" do
      patch toggle_complete_path(task.id)
      
      expect(task.completed).must_be_nil
    end
    
    it "will redirect to task index for invalid task" do
      patch toggle_complete_path(-1)

      must_redirect_to tasks_path
    end
  end
end
