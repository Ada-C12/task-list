<!-- <ul>
<% @tasks.each do |task|%>
    <li>
    <a href="/tasks/1"> <%= task[:task]%></a>
    </li>
<% end %>
</ul> -->


test cases

Predict and describe the changes that will need to happen in each file (in one sentence each):
- routes
  Make sure we have a delete path!
  delete '/books/:id', to: 'books#destroy'
    (book_path)
- What should happen to the user on nominal and edge cases? What are the edge cases?
  Deleting is successful!
    Arrange:
      Create a Book... then find the newly created book's id
    Act-Assert:
      Expect Differ: The book count goes down by one after we do "delete book_path( the newly created book's id )
    Assert:
      Must redirect to the root page
  Trying to delete a book that doesn't exist
    Arrange:
      Book.destroy_all
    
    Act-Assert:
      Expect Differ: The book count does not change after we do "delete book_path( any id )"
    Assert:
      Must redirect to the books_path
  Trying to delete the same thing twice
    Arrange:
      Create a new Book/Task and get its id
      Delete that book/task by its id
    Act-Assert:
      Expect Differ: The book count does not change after we do "delete book_path( that same above id )"
    Assert:
      Must redirect to the books_path
- BooksController
  Add a destroy action!
  We will find the right book using the id found in params
  Then, depending on if we find it...
    we will either destroy it, then we will redirect to root page
    or not! and we will redirect to index page
- BooksController test
- Views
  Add a delete button in the list of books next to each book... make sure this button goes to the correct route
- Model
  No changes to the model!
Collapse



