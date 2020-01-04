require 'test_helper'

class NoteControllerTest < ActionDispatch::IntegrationTest
  test "should authenticate to visit notes index" do
    get notes_url, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
      Rails.application.secrets.auth_username,
      Rails.application.secrets.auth_password) }
    assert_response :ok
  end

  test "should get unauthorized without authentication " do
    get notes_url
    assert_response :unauthorized
  end
end
