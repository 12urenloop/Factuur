require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note = Note.first
    @auth_headers = { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
      Rails.application.secrets.auth_username,
      Rails.application.secrets.auth_password)
    }
  end

  test "should get index" do
    get notes_url, headers: @auth_headers
    assert_response :success
  end

  test "should get new" do
    get new_note_url, headers: @auth_headers
    assert_response :success
  end

  test "should show note" do
    get note_url(@note), headers: @auth_headers
    assert_response :success
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete note_url(@note), headers: @auth_headers
    end

    assert_redirected_to notes_url
  end
end
