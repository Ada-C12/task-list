ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
<<<<<<< HEAD
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

=======
>>>>>>> 8422e7d8fbdad8f1e62c64e1ee6db43e6b58360d

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
<<<<<<< HEAD
  
=======

>>>>>>> 8422e7d8fbdad8f1e62c64e1ee6db43e6b58360d
  # Add more helper methods to be used by all tests here...
end
