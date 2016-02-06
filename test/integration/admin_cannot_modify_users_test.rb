require 'test_helper'

class AdminCannotModifyOtherUsersDataTest < ActionDispatch::IntegrationTest
  test "admin can modify their account data" do
    @admin = create_admin
    visit login_path
    fill_in "Username", with: "admin"
    fill_in "Password", with: "password"
    click_button "Login"

    visit admin_dashboard_path(id: @admin.id)
    click_button "Edit Profile"

    fill_in "user_username", with: "UpdatedAdmin"
    fill_in "user_password", with: "updatedpassword"
    fill_in "user_first_name", with: "updatedfirstname"
    fill_in "user_last_name", with: "updatedlastname"

    click_button "Update Profile"

    assert_equal admin_dashboard_path(id: @admin.id), current_path
    assert page.has_content?("UpdatedAdmin")
    assert page.has_content?("updatedlastname")
    assert page.has_content?("updatedfirstname")
  end

  test "admin cannot modify other users account data" do
    @admin = create_admin
    visit login_path
    fill_in "Username", with: "admin"
    fill_in "Password", with: "password"
    click_button "Login"
    admin_id = @admin.id

    visit '/users'
    assert page.has_content?("Stranger danger!")

    visit '/users/1'
    assert page.has_content?("Stranger danger!")
  end
end
