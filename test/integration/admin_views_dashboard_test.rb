require 'test_helper'

class AdminViewsDashboardTest < ActionDispatch::IntegrationTest
  test "admin can view the admin profile" do
    admin = create_admin
    login_admin
    visit admin_dashboard_path(id: admin.id)
    assert page.has_content?("Admin Profile")
  end

  test "admin can view the admin dashboard" do
    admin = create_admin
    login_admin
    visit admin_dashboard_index_path
    assert page.has_content?("Admin Dashboard")
  end

  test "registered user is routed to homepage when visiting admin dashboard" do
    user = create_lender
    login_lender

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit admin_dashboard_index_path
    refute page.has_content?("Admin Dashboard")
    assert_equal root_path, current_path
  end

  test "guest is routed to homepage when visiting admin dashboard" do
    visit admin_dashboard_index_path
    refute page.has_content?("Admin Dashboard")
    assert_equal root_path, current_path
  end
end
