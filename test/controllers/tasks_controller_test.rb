require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completion_date: Time.now + 5.days
  }
  ############################################
  # Wave 1
  ############################################
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
  ############################################
  # Wave 2
  ############################################
  describe "show" do
    it "can get a valid task" do
      # Act: sending user down task_path w/ task.id, triggering Ctrler#show, and GETs user to /tasks/:id
      get task_path(task.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid task" do
      # Act: going down task_path w/ id=-1, triggering Tasks.show() trying to GET user to /tasks/-1.html
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
      # expect(flash[:error]).must_equal "Could not find task with id: -1"
    end
  end
  
  describe "new" do
    it "can get the new task page" do
      
      # Act: going down new_task_path, triggering TasksCtrler.new(), to GET user to /tasks/new.html
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
        # going down tasks_path & POST triggers TasksCtrler.create(), which 
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      # I deactivated line below, b/c if completion_date is set to nil, how can you .to_time() on nil?
      # expect(new_task.completion_date.to_time.to_i).must_equal task_hash[:task][:completion_date].to_i
      # so I changed it to this line instead lol
      expect(new_task.completion_date).must_equal nil
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  ############################################
  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      skip
      # Your code here
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      skip
      # Your code here
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      # Your code here
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Your code here
    end
  end
  ############################################
  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
