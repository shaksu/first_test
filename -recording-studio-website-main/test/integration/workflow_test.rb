require 'test_helper'

class WorkflowTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "login and browse site" do
    https!             # login via https
    get "/users/sign_up"
    assert_response :success
    assert_nil flash[:notice]

    https!(false)
    get "/tasks/index_all"
    assert_response :success
    assert assigns(nil)
  end

   def log_in
     delete '/users/sign_out'
     get '/users/sign_up', params: {
       user: {
           email: 'Admin@ya.ru',
         password: '12345678'
       }
     }
   end

   test 'sign_in' do
    log_in
   end

   test "create task" do
     log_in
     get '/tasks/new'
     post "/tasks",
      params: {
          ask: {
              subj: "can create tasks",
              descript: "task was successfully created"
          }
      }
      assert_redirected_to 'http://www.example.com/users/sign_in?locale=en'
   end

   test 'sign_up' do
     delete '/users/sign_out'
     get '/users/sign_up', params: {
         user: {
             login: rand(1000000).to_s + '@ya.ru',
             password: 123456
         }
     }
      assert_response :success
   end
end
