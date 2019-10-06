require "test_helper"

describe TasksController do
  let (:task) { Task.create name: "sample task", description: "this is an example for a test", completion_datetime: Time.now + 5.days }
  let (:anonymous_hash) { { task: { name: "", description: "anonymous troll" } } }
  let (:crappy_hash) { { task: { garbage: "garbage" } } }
  let (:nil_name_hash) { { task: { name: nil } } }
  let (:new_hash) { { task: { name: "come on", description: "be cool", completion_datetime: Time.now } } }
  
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
      task_hash = { task: { name: "new task", description: "new task description" } }
      
      # Act-Assert
      # going down tasks_path & POST triggers TasksCtrler.create()
      expect { post tasks_path, params: task_hash }.must_change "Task.count", 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_datetime).must_equal task_hash[:task][:completion_datetime]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
    
    it "If bad args given, won't create task and will render form again" do
      bad_args = [ anonymous_hash, crappy_hash, nil_name_hash ]
      bad_args.each do |bad|
        expect { post tasks_path, params: bad }.must_differ "Task.count", 0
        must_respond_with 200
      end
      # yeah... couldn't figure out how to test for the rendered form, only that it got 200
      # i think we're not supposed to be able to test for render? Can't even test for a must_redirect_to self... idk...
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
    
    it "can update an existing task" do
      # going down edit_tasks_path & PATCH triggers TasksCtrler.update()
      patch task_path(task.id), params: new_hash
      
      updated_task = Task.find_by(id: task.id)
      assert (updated_task.id == task.id)
      expect(updated_task.name).must_equal new_hash[:task][:name]
      expect(updated_task.description).must_equal new_hash[:task][:description]
      
      db_time = updated_task.completion_datetime.getlocal
      input_time = new_hash[:task][:completion_datetime]
      # assert (db_time == input_time) will FAIL b/c they don't share same memory address!
      # I can test their string form
      expect(db_time.to_s).must_equal input_time.to_s
      # or I can test their attribs
      expect(db_time.year == input_time.year)
      expect(db_time.month == input_time.month)
      expect(db_time.day == input_time.day)
      expect(db_time.hour == input_time.hour)
      expect(db_time.min == input_time.min)
      expect(db_time.sec == input_time.sec)
      
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
    
    it "If bad args given, won't update task and will render form again" do
      bad_args = [ anonymous_hash, nil_name_hash ]
      bad_args.each do |bad|
        expect { patch task_path(task.id), params: bad }.wont_change "task.updated_at"
        must_respond_with 200
      end
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
      let (:hard_task) { Task.create name: "super hard", description: "not done yet" }
      
      # it "Check: completion_datetime goes from nil to correct datetime value" do
      #   assert_nil (hard_task.completion_datetime)
      
      #   puts "", hard_task.attributes, "VS"
      #   patch toggle_path(id: hard_task.id), params: { destination: "root" }
      #   now = Time.now
      #   puts hard_task.attributes
      
      #   must_redirect_to root_path
      #   expect (hard_task.completion_datetime).must_be_close_to now, 0.1
      # end
      
      
    end
    
    # describe "If toggling task back to incomplete..." do
    #   let (:easy_task) { Task.create name: "super easy", description: "finished!", completion_datetime: Time.now + 5.days }
    
    #   it "Check: completion_datetime goes from datetime obj to nil" do
    #     assert (easy_task.completion_datetime)
    
    #     patch toggle_path, params: {id: easy_task.id }
    
    #     assert (easy_task.completion_datetime == nil )
    #   end
    # end
    
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


