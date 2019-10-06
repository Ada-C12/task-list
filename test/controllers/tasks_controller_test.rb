require "test_helper"

describe TasksController do
  let (:task) { Task.create name: "sample task", description: "this is an example for a test", completion_status: true, completion_datetime: Time.now + 5.days }
  let (:bad_hash) { { task: { name: "", description: "anonymous troll", completion_status: nil } } }
  
  ############################################
  # Wave 1
  ############################################
  describe "INDEX" do
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
  describe "SHOW" do
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
  
  describe "NEW" do
    it "can get the new task page" do
      
      # Act: going down new_task_path, triggering TasksCtrler.new(), to GET user to /tasks/new.html
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "CREATE" do
    it "can create a new task" do
      
      # Arrange
      task_hash = { task: { name: "new task", description: "new task description", completion_status: nil } }
      
      # Act-Assert
      # going down tasks_path & POST triggers TasksCtrler.create()
      expect { post tasks_path, params: task_hash }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      # I deactivated line below, b/c if completion_status is set to nil, how can you .to_time() on nil?
      # expect(new_task.completion_status.to_time.to_i).must_equal task_hash[:task][:completion_status].to_i
      expect(new_task.completion_status).must_equal task_hash[:task][:completion_status]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
    
    it "I ADDED THIS: if bogus args, won't create task and will render form again" do
      expect { post tasks_path, params: bad_hash }.must_differ "Task.count", 0
      # yeah... couldn't figure out how to test for the rendered form, only that it got 200
      # i think we're not supposed to be able to test for render? idk...
      must_respond_with 200
    end
  end
  ############################################
  # Wave 3
  ############################################
  describe "EDIT" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-666)
      must_redirect_to root_path
    end
  end
  
  describe "UPDATE" do
    let (:new_hash) { { task: { name: "come on", description: "be cool", completion_status: nil } } }
    
    it "can update an existing task" do
      # Arrange
      new_hash
      task
      
      # Act-Assert
      # going down edit_tasks_path & PATCH triggers TasksCtrler.update()
      patch task_path(task.id), params: new_hash
      
      updated_task = Task.find_by(id: task.id)
      assert (updated_task.id == task.id)
      expect(updated_task.name).must_equal new_hash[:task][:name]
      expect(updated_task.description).must_equal new_hash[:task][:description]
      expect(updated_task.completion_status).must_equal new_hash[:task][:completion_status]
      
      must_respond_with :redirect
      must_redirect_to task_path(updated_task.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      bad_ids = [-666, "garbage"]
      bad_ids.each do |bad|
        patch task_path(bad), params: new_hash
        must_redirect_to root_path
      end
    end
    
    it "if changes fail to save to test, it should stay rendered on page (code 200)" do
      # If there was a way to fail to save the changes to a task, that would be a great thing to test.
      # I added validation code in Model, which would make @update/@save return F if name==""
      patch task_path(task.id), params: bad_hash
      # I made failed saves stay on rendered form w/ same info, thus code 200
      must_respond_with 200
    end
    
  end
  ############################################
  # Wave 4
  ############################################
  describe "DESTROY" do
    
    it "destroys a task correctly, and redirect to root path afterwards" do 
      task
      before_count = Task.count
      delete task_path(task.id)
      after_count = Task.count
      assert (before_count == after_count + 1)
      
      must_redirect_to root_path
    end
    
    it "trying to destroy a bogus task will not affect database, also will redirect to root path" do
      before_count = Task.count
      delete task_path(-666)
      after_count = Task.count
      assert (before_count == after_count)
      
      must_redirect_to root_path
    end
    
    it "trying to destroy same task id twice will not affect database, also will redirect to root path" do
      id = task.id
      before_count = Task.count
      delete task_path(id)
      # trying to delete it again
      after_count = Task.count
      delete task_path(id)
      second_after_count = Task.count
      assert (before_count == after_count + 1)
      assert (after_count == second_after_count)
      
      must_redirect_to root_path
    end
    
  end
  
  describe "TOGGLE" do
    describe "If toggling task to complete..." do
      let (:hard_task) { Task.create name: "super hard", description: "not done yet", completion_status: nil, completion_datetime: nil }
      it "Check: completion_status goes from nil to true" do
        # assert (hard_task.completion_status == nil )
        # patch toggle_path, params: {id: hard_task.id}
        # # puts "HARD!!!", hard_task.completion_status
        # puts hard_task.attributes
        # # assert (hard_task.completion_status == true )
      end
      
      it "Check: complete_datetime goes from nil to datetime obj" do


      end
    end
    
    describe "If toggling task back to incomplete..." do
      let (:easy_task) { Task.create name: "super easy", description: "finished!", completion_status: true, completion_datetime: Time.now + 5.days }
      
      it "Check: completion_status goes from true to nil or false" do
        assert (easy_task.completion_status == true )
        
        puts "STARTED AS:"
        puts easy_task.completion_status, easy_task.completion_datetime
        puts "TOGGLE HERE!"
        patch toggle_path, params: {id: easy_task.id}
        
        puts easy_task.completion_status, easy_task.completion_datetime
        expect (easy_task.completion_status ).must_be true
      end
      
      it "Check: complete_datetime goes from datetime obj to nil" do



      end
    end
    
    it "Edge case: trying to toggle a nonexistent task will get 404" do
      patch toggle_path, params: {id: -666 }
      must_respond_with 404
    end
    
  end
end





# describe "FOUND ONLINE BUT DID NOT WORK FOR ME" do

#   it "assert_routing to homepage" do
#     assert_routing '/', controller: 'tasks', action: 'index'
#   end

#   it "assert_routing to show a specific id" do
#     id = task.id
#     assert_routing "/tasks/#{id}", controller: 'tasks', action: 'show', id: id
#   end

# end


