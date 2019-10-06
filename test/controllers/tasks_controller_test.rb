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
      
      # 
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
      # expect(new_task.due_date.to_time.to_i).must_equal task_hash[:task][:due_date].to_i
      # expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]
      expect(new_task.completion_date).must_be_nil task_hash[:task][:completion_date]
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      
      get edit_task_path(task.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      # invalid_id = task_path(-1)
      
      get edit_task_path(8923749234)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    before do
      @new_task = Task.create(name: "Laundry", description: "Wash and dry", completion_date: nil)
    end
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    updated_task_form_data = {
      task: {
        name: "Clean Windows",
        description: 'Use windex',
        completion_date: Time.now + 7.days
      }
    }
    it "can update an existing task" do
      expect {
        patch task_path(@new_task.id), params: updated_task_form_data
      }.wont_change "Task.count"
      
      @new_task.reload
      
      expect(@new_task.name).must_equal "Laundry"
    end
    
    it "will redirect to the root page if given an invalid id" do
      
      patch task_path(2348734)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
    it "can destroy a task" do
      task_to_be_destroyed = Task.create(
        name: "See ya task", 
        description: "This don't matta", 
        completion_date: nil)
        
        task_to_be_destroyed_id = task_to_be_destroyed.id
        
        expect {
          delete task_path(task_to_be_destroyed_id)
        }.must_differ 'Task.count', -1        
        # get task_path(@task_to_be_destroyed.id)
        # must_respond_with :redirect
        must_redirect_to root_path
      end 
    end
    
    # Complete for Wave 4
    describe "toggle_complete" do
      
      it "will mark completed tasks as complete" do
        another_task = Task.create(
          name: "new task", 
          description: "anotha one",
          completion_date: nil
        )
        another_task_id = another_task.id
        today = DateTime.now
        
        patch complete_task_path(another_task_id)
        
        expect(Task.find_by(id: another_task.id).completion_date).wont_be_nil
      end
    end
    
    describe "toggle_incomplete" do
      
      it "will mark incompleted tasks as incomplete" do
        another_task_2 = Task.create(
          name: "new task", 
          description: "anotha one",
          completion_date: DateTime.now
        )
        another_task_id_2 = another_task_2.id
        today = DateTime.now
        
        patch incomplete_task_path(another_task_id_2)
        
        expect(Task.find_by(id: another_task_2.id).completion_date).must_be_nil
      end
    end
  end 
  