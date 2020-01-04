require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = Contact.first
    @auth_headers = { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
      Rails.application.secrets.auth_username,
      Rails.application.secrets.auth_password)
    }
  end

  test "should get index" do
    get contacts_url, headers: @auth_headers
    assert_response :success
  end

  test "should get new" do
    get new_contact_url, headers: @auth_headers
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post contacts_url, params: { contact: { name: "Bart" } }, headers: @auth_headers
    end

    assert_redirected_to contacts_url
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { name: "Pan" } }, headers: @auth_headers
    assert_redirected_to contacts_url
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete contact_url(@contact), headers: @auth_headers
    end

    assert_redirected_to contacts_url
  end
end
