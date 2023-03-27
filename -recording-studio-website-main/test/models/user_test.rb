require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test 'should not save new empty User' do
     user = User.new
     assert !user.save
   end

   test 'should save not empty User' do
     user = User.new
     user.email = 'luchkin@fedor.com'
     user.password = '4742746'
     assert user.save
   end
end
