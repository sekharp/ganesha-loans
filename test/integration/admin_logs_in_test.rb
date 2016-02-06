require 'test_helper'

class AdminLogsInTest < ActionDispatch::IntegrationTest
  test "admin logs in and redirects to admin dashboard" do
    admin = create_admin
    visit login_path

    fill_in "Username", with: "admin"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal admin_dashboard_path(id: admin.id), current_path
    assert page.has_content?("Admin Dashboard")
  end
end
