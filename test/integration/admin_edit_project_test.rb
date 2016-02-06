require "test_helper"

class AdminEditProjectTest < ActionDispatch::IntegrationTest
  def setup
    create_roles_borrower_project_and_lender
    create_admin
    login_admin
  end

  test "admin can edit project status from dashboard" do
    visit admin_dashboard_index_path

    assert admin_dashboard_index_path, current_path
    assert page.has_content?("Active")

    click_link "Mark as Completed"

    assert page.has_content?("Completed")
  end
end
