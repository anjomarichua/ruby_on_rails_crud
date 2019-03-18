require 'test_helper'

class OrganisationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organisation_index_url
    assert_response :success
  end

  test "should get show" do
    get organisation_show_url
    assert_response :success
  end

  test "should get new" do
    get organisation_new_url
    assert_response :success
  end

  test "should get create" do
    get organisation_create_url
    assert_response :success
  end

  test "should get edit" do
    get organisation_edit_url
    assert_response :success
  end

  test "should get update" do
    get organisation_update_url
    assert_response :success
  end

  test "should get destroy" do
    get organisation_destroy_url
    assert_response :success
  end

end
