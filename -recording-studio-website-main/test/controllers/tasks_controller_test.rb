require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get task_url(@task)
    assert_response :success
  end

  test "should get new" do
    get task_url(@task)
    assert_response :success
  end

  test "should create task" do
    get task_url(@task)
    assert_response :success
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { descript: @task.descript, status: @task.status, subj: @task.subj } }
    assert_response :success
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end
    assert_redirected_to "http://www.example.com/tasks?locale=en"
  end

  test "should route to task" do
    assert_routing '/tasks/1',
                   { :controller => "tasks", :action => "show", :id => "1" }
  end

end
