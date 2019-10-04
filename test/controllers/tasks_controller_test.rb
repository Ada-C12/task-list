require 'test_helper'

describe TasksController do
  # Tests for Wave 1
  describe '#index' do
    it 'can get the index path' do
      # Act
      get tasks_path
      
      # Assert
      must_respond_with :success
    end
    
    it 'can get the root path' do
      # Act
      get root_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  #Wave 2
  describe '#show' do
    it 'can get a valid task' do
      # Setup
      task = Task.create(
        id: 1, 
        name: 'sample task', 
        description: 'this is an example for a test',
        completed_at: Time.now + 5.days
      )
      
      # Act
      get task_path(task)
      
      # Assert
      must_respond_with :success
    end
    
    it 'will redirect for an invalid task' do
      # skip
      # Act
      get task_path(-1)
      
      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'
    end
  end
  
  describe 'new' do
    it 'can get the new task page' do
      # skip
      
      # Act
      get new_task_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe 'create' do
    it 'can create a new task' do
      # skip
      
      # Arrange
      task_hash = {
        task: {
          id: 1,
          name: 'new task',
          description: 'new task description',
          completed_at: nil,
        }
      }
      
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change 'Task.count', 1
      
      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed_at).must_equal task_hash[:task][:completed_at]
      
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end
  
  # Wave 3
  describe '#edit' do
    describe 'when the task exists' do
      it 'returns 200' do 
        # Setup
        task = Task.create(
          id: 1, 
          name: 'sample task', 
          description: 'this is an example for a test',
          completed_at: Time.now + 5.days
        )
        
        # Act
        get edit_task_path(task)
        
        # Assert
        must_respond_with :success
      end
    end
    
    describe 'when the task does not exist' do
      it 'redirects the user to the tasks list' do
        # Act
        get edit_task_path(-1)
        # Assert
        must_respond_with :redirect
        must_redirect_to tasks_path
      end
    end
  end
  
  describe '#update' do
    describe 'when the task exists' do
      it 'updates the name and description attributes when it saves successfully' do
        # setup
        task = Task.create(
          id: 1, 
          name: 'sample task', 
          description: 'this is an example for a test',
          completed_at: Time.now + 5.days
        )
        
        params = {
          task: {
            name: 'new name',
            description: 'new description',
            id: task.id,
          }
        }
        # act
        put task_path(task.id), params: params
        
        # This reloads the `task` object with the new data updated in line 143.
        task.reload
        
        # assert
        assert_equal params[:task][:name], task.name
        assert_equal params[:task][:description], task.description
        must_respond_with :redirect
        must_redirect_to task_path(task)
      end
      
      # it 'renders the edit page with the form pre-filled with the entered values' do
      # end
    end
    
    describe 'when the task does not exist' do
      it 'redirects to tasks list' do
        # Setup
        params = {
          task: {
            name: 'new name',
            description: 'new description',
            id: -1,
          }
        }
        
        # Act
        put task_path(-1), params: params
        
        # Assert
        must_respond_with :redirect
        must_redirect_to tasks_path
      end
    end
    
    # it 'will redirect to the root page if given an invalid id' do
    #   # skip
    #   get task_path
    #   must_respond_with :redirect
    #   must_redirect_to root_path
    # end
  end
  
  
  
  
  #Wave 4
  describe '#destroy' do
    describe 'when the task exists' do 
      it 'deletes the tasks and redirect the user to tasks list when successful' do
        task = Task.create(
          id: 1, 
          name: 'sample task', 
          description: 'this is an example for a test',
          completed_at: Time.now + 5.days
        )
        
        params = { id: task.id }
        delete task_path(task.id), params: params
        
        assert_nil Task.find_by(id: task.id)
      end
    end 
    
    describe 'when the task does not exist' do
      it 'redirects to tasks list' do
        # Setup
        params = {
          task: {
            name: 'new name',
            description: 'new description',
            id: -1,
          }
        }
        
        # Act
        put task_path(-1), params: params
        
        # Assert
        must_respond_with :redirect
        must_redirect_to tasks_path
      end
    end
    
  end
  
  
  # COMPLETE METHOD
  describe '#complete' do
    
    describe 'when the task exists' do 
      it 'updates the completed_at attributes to current time' do
        # setup
        task = Task.create(
          id: 1, 
          name: 'sample task', 
          description: 'this is an example for a test',
          completed_at: nil,
        )
        
        params = {
          task: {
            completed_at: Time.now,
            id: task.id,
          }
        }
        # act
        put task_path(task.id), params: params
        
        # This reloads the `task` object with the new data updated in line 143.
        task.reload
        
        # assert
        assert_not_nil params[:task][:completed_at]
        must_respond_with :redirect
        must_redirect_to task_path(task)
      end
    end
    
    describe 'when the task does not exist' do
      it 'redirects to tasks list' do
        # Setup
        params = {
          task: {
            name: 'new name',
            description: 'new description',
            id: -1,
          }
        }
        
        # Act
        put task_path(-1), params: params
        
        # Assert
        must_respond_with :redirect
        must_redirect_to tasks_path
      end
    end
  end
  
  
  
end
