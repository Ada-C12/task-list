require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: Time.now + 5.days
  }

  let(:invalid_task_hash) { 
    {
      task: {
        name: "",
        description: "",
        } 
      }
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
      expect(new_task.completed).must_equal nil
      #Need to change to 'assert_nil' but having trouble finding correct syntax and documentation for this

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end

    it "will raise an error for creating a task with invalid arguments" do 
      expect { post tasks_path, params: invalid_task_hash }.must_differ "Task.count", 0
      must_respond_with 200
      #Weird bug here I think? I want to figure out how to check for a rendered form, but my page redirects to /tasks despite displaying the form again with if invalid entry. On StackOverflow I found out it might be because #index is before #create in routes - but I also can't figure out how to rewrite the order of that.
    end 

  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success 
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_redirect_to task_path
    end
  end

  describe "update" do
    before do 
      Task.create(name:"Chores", description:"Mop the floor")

      @new_task_hash = {
        task: {
        name: "Homework",
        description: "Complete personal portfolio",
        completed: DateTime.new(10/6/19),
        },
    }
    end 

    it "can update an existing task successfully and redirects to home" do
      existing_task = Task.first 
      id = existing_task.id

      expect {
        patch task_path(id), params: @new_task_hash 
      }.wont_change "Task.count"

      expect(Task.find_by(id: existing_task.id).description).must_equal "Complete personal portfolio"

      expect(Task.find_by(id: existing_task.id).name).must_equal "Homework"

      #Validating that the completed field holds a DateTime object, which I think is called this weird thing in Rails?
      expect(Task.find_by(id: existing_task.id).completed).must_be_kind_of ActiveSupport::TimeWithZone

      expect(Task.find_by(id: existing_task.id).completed).must_equal DateTime.new(10/6/19)

      must_redirect_to task_path(existing_task.id)

    end

    it "will redirect to the root page if given an invalid id" do
      invalid_id = [-1, "woops"]
      invalid_id.each do |id|
        patch task_path(invalid_id)
        must_redirect_to root_path
      end
    end

    it "won't update a task with invalid form entries" do
      expect { patch task_path(task.id), params: invalid_task_hash }.wont_change "task.updated_at"
    end 

  end

  describe "destroy" do
    it "destroys a task correctly, and redirect to root path afterwards" do 
      
      before_deletion_count = Task.count
      delete task_path(task.id)
      after_deletion_count = Task.count

      assert (before_deletion_count == after_deletion_count)

      must_redirect_to root_path
    end 

    it "redirects to task index and does not actually delete a nonexistent book" do
      Task.destroy_all
      invalid_task_id = 1

      expect { delete task_path(invalid_task_id).must_differ "Task.count", 0 }
    end 

    it "redirects to task index if trying to delete a task that has already been deleted" do 
      Task.create(name:"test", description:"TEST")
      task_id = Task.find_by(name:"test").id
      Task.destroy_all

      expect{ delete task_path(task_id)}.must_differ "Task.count", 0

      must_redirect_to root_path 
    end 
  end

  # Complete for Wave 4
  describe "completed task" do
    it "completed changes from nil to current datetime, and redirects to home" do
      #arrange
      test_task = Task.create(name: "Testing", description: "in process")

      #act
      patch completed_task(id:test_task.id), params: {destination: "root"} 
      #Keep getting an error message that says undefined method for 'completed_task.'
      #Stuck on how to test this method.. will try to ask for help and come in early Monday

    end 
  end
end
