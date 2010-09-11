require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:folders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create folder" do
    assert_difference('Folder.count') do
      post :create, :folder => { }
    end

    assert_redirected_to folder_path(assigns(:folder))
  end

  test "should show folder" do
    get :show, :id => folders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => folders(:one).to_param
    assert_response :success
  end

  test "should update folder" do
    put :update, :id => folders(:one).to_param, :folder => { }
    assert_redirected_to folder_path(assigns(:folder))
  end

  test "should destroy folder" do
    assert_difference('Folder.count', -1) do
      delete :destroy, :id => folders(:one).to_param
    end

    assert_redirected_to folders_path
  end
end
