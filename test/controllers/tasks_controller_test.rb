require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completion_date: Time.now + 5.days
  }
  
  # Wave 1
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
  
  # Wave 2
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
          completion_date: nil,
        },
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
    
    it "redirect to new_task page if input is not valid" do
      task_hashes = [
        {
          task: {
            name: "No description",
            description: nil,
            completion_date: nil,
          },
        },
        {
          task: {
            name: nil,
            description: "No name task description",
            completion_date: nil,
          },
        }   
      ]
      
      task_hashes.each do |task_hash|
        expect {
          post tasks_path, params: task_hash
        }.must_differ "Task.count", 0
        
        must_respond_with :redirect
        must_redirect_to new_task_path
      end
    end
  end
  
  # Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task[:id])
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  # Wave 3
  describe "update" do
    before do 
      @task_hash = {
        task: {
          name: "updated task",
          description: "updated task description"
        }
      }
    end

    it "can update an existing task" do
      existing_task = Task.find_by(id: task[:id])
      expect _(Task.count).must_equal 1
      expect _(Task.all.first[:name]).must_equal existing_task[:name]
      expect _(Task.all.first[:description]).must_equal existing_task[:description]
      
      expect { 
        patch task_path(Task.first.id), params: @task_hash
      }.must_differ "Task.count", 0
      
      expect _(Task.first.name).must_equal @task_hash[:task][:name]
      expect _(Task.first.description).must_equal @task_hash[:task][:description]
      expect _(Task.first.completion_date).must_equal @task_hash[:task][:completion_date]
      must_respond_with :redirect
      must_redirect_to task_path
      
    end
    
    it "will redirect to the root page if given an invalid id" do
      expect {
        patch task_path(-1), params: @task_hash
      }.must_differ "Task.count", 0
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
    it "redirect to new_task page if input is not valid and save fails" do
      task_hashes = [
        {
          task: {
            name: "No description",
            description: nil,
            completion_date: nil,
          },
        },
        {
          task: {
            name: nil,
            description: "No name task description",
            completion_date: nil,
          }
        }   
      ]
      
      existing_task = Task.find_by(id: task[:id])
      expect _(Task.count).must_equal 1
      expect _(Task.all.first[:name]).must_equal existing_task[:name]
      expect _(Task.all.first[:description]).must_equal existing_task[:description]
      
      task_hashes.each do |task_hash|
        expect { 
            patch task_path(Task.all.first.id), params: task_hash
        }.must_differ "Task.count", 0
            
        must_respond_with :redirect
        must_redirect_to edit_task_path(Task.all.first[:id])
      end
    end
  end
  
  # Wave 4
  describe "destroy" do
    it "can delete an existing task" do
      existing_task = Task.find_by(id: task[:id])
      existing_task_id = Task.all.first.id
      expect _(Task.count).must_equal 1
      
      expect {
        delete task_path(existing_task_id)
      }.must_differ "Task.count", -1
      
      assert_nil (Task.find_by(id: existing_task_id))
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
    it "will redirect to the index page if given an invalid id" do
      expect {
        delete task_path(-1)
      }.must_differ "Task.count", 0
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
    it "will redirect to the index page if requested on the same task twice" do
      existing_task = Task.find_by(id: task[:id])
      existing_task_id = Task.all.first.id
      delete task_path(existing_task_id)
      expect _(Task.count).must_equal 0
      
      expect {
        delete task_path(existing_task_id)
      }.must_differ "Task.count", 0
      
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    # Complete for Wave 4
  end
end
