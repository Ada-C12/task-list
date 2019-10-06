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
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      
      must_respond_with :success, "#{task.id}"
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    it "can update an existing task" do
      updated_task_data = {
        task: {
          name: "Walk dog",
          description: "Walk the dog",
          completion_date: "10-03-2019",
        },
      }
      task_url = "/tasks/" + "#{task.id}"
      
      patch task_url, params: updated_task_data
      
      expect(Task.count).must_equal 1
      must_redirect_to task_path(id: task.id)
      expect(Task.find_by(id: task.id).name).must_equal "Walk dog"
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch '/tasks/0', params: {
        task: {
          name: "Walk dog",
          description: "Walk the dog",
          completion_date: "10-03-2019",
        },
      }
      must_redirect_to root_path
    end
    
    it "will not update if given invalid params" do
      new_task = Task.create(
        name: "Make dinner", 
        description: "figure out something edible from the fridge",
        completion_date: nil
      )
      
      expect {
        patch task_path(new_task_id), params: {}
      }.must_raise 
      expect(new_task.name).must_equal "Make dinner"
      expect(new_task.description).must_equal "figure out something edible from the fridge"
      expect(new_task.completion_date).must_be_nil
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it 'successfully deletes a task and redirects to the root path' do
      new_task = Task.create(
        name: "Make dinner", 
        description: "figure out something edible from the fridge",
        completion_date: nil
      )
      new_task_id = new_task.id

      expect{
        delete task_path(new_task_id)
      }.must_differ "Task.count", -1

      must_redirect_to root_path
    end

    it "redirects to the tasks path and does not delete any tasks if the task does not exist" do
      Task.destroy_all
      new_task = Task.create(
        name: "Make dinner", 
        description: "figure out something edible from the fridge",
        completion_date: nil
      )
      invalid_task_id = 600

      expect {
        delete task_path(invalid_task_id)
      }.must_differ "Task.count", 0
      expect(new_task.id).wont_equal invalid_task_id

      must_redirect_to tasks_path
    end

    it "redirects to the tasks path and does not delete any tasks if the task has already been deleted" do
      new_task = Task.create(
        name: "Make dinner", 
        description: "figure out something edible from the fridge",
        completion_date: nil
      )
      new_task_id = new_task.id
      Task.destroy_all

      expect {
        delete task_path(new_task_id)
      }.must_differ "Task.count", 0

      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
