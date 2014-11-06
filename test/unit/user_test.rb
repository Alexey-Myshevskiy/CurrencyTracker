require 'test_helper'

class UserTest < ActiveSupport::TestCase
   def test_user_size_must_be_over_then_0
     user1=User.new
     user1.save
     assert_equal 1,user1.size
   end
end
