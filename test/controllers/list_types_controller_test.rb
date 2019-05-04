require 'test_helper'

class ListTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list_type = list_types(:one)
  end

  test "should get index" do
    get list_types_url
    assert_response :success
  end

  test "should get new" do
    get new_list_type_url
    assert_response :success
  end

  test "should create list_type" do
    assert_difference('ListType.count') do
      post list_types_url, params: { list_type: { noun: @list_type.noun, title: @list_type.title, verb: @list_type.verb } }
    end

    assert_redirected_to list_type_url(ListType.last)
  end

  test "should show list_type" do
    get list_type_url(@list_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_type_url(@list_type)
    assert_response :success
  end

  test "should update list_type" do
    patch list_type_url(@list_type), params: { list_type: { noun: @list_type.noun, title: @list_type.title, verb: @list_type.verb } }
    assert_redirected_to list_type_url(@list_type)
  end

  test "should destroy list_type" do
    assert_difference('ListType.count', -1) do
      delete list_type_url(@list_type)
    end

    assert_redirected_to list_types_url
  end
end
