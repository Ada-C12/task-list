require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
    completed: Time.now + 5.days
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
      # expect(flash[:error]).must_equal "Could not find task with id: -1"
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
      }.must_change 'Task.count', 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      #expect(new_task.due_date.to_time.to_i).must_equal task_hash[:task][:due_date].to_i
      expect(new_task.completed).must_equal task_hash[:task][:completed]
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Unskip and complete these tests for Wave 3
  
  describe "edit" do
    it "can get the edit page for an existing task" do
      
      #  Stepone Call on Edit#Action using path
      #  Step Two: call on let(task) which is a local variable that will hold an created task. 
      #  Step Three: What will the respond be...must_respond_with what? What do you expect. You expect it to return the task
      get edit_task_path(task[:id])
      
      must_respond_with :success
      
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      
      get edit_task_path(-1)
      
      must_respond_with :redirect 
      must_redirect_to tasks_path
    end
  end
  
  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      
      #Arrange:
      #step one get an existing book
      #Step two once you have the existing book, change the name of the task. 
      existing_task = task
      updated_task_form_data = {
        task: {
          name: "cs fun",
          description: "Recursion practice",
          completed: Date.today
        }
      }
      #Act:
      #actually update the book data with the new hash form data you created.
      patch task_path(existing_task.id), params: updated_task_form_data
      
      # Assert
      #Step Three once you change the fields, check to see if they are different than original 
      #expect(Book.find_by(id: existing_book.id).title).must_equal "Name that you changed book to"
      
      expect(Task.find_by(id: existing_task.id).name).must_equal "cs fun"
      expect(Task.find_by(id: existing_task.id).description).must_equal "Recursion practice"
      expect(Task.find_by(id: existing_task.id).completed).must_equal Date.today
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Arrange:
   
      updated_task_form_data = {
        task: {
          name: "cs fun",
          description: "Recursion practice",
          completed: Date.today
        }
      }
    
      patch task_path(-1), params: updated_task_form_data
      # Assert:
     must_respond_with :redirect
     must_redirect_to root_path
    end
  end
  
  # Complete these tests for Wave 4
  describe "destroy" do
   
    it "successfully deletes an existing task and then redirects to home page" do

    created_task = task
    expect{
      delete task_path(created_task.id)
    }.must_differ "Task.count", -1

    must_redirect_to root_path

    
  
  end
    
  end
  
  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
