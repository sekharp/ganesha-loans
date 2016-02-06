require 'test_helper'

class UserDashboardTest < ActionDispatch::IntegrationTest
  test "authenticated lender routed to lender dashboard from login" do
    create_roles_borrower_project_and_lender
    visit login_path

    within(".login-form") do
      fill_in "Username", with: "mdoe"
      fill_in "Password", with: "password"
      click_button "Login"
    end

    assert_equal "/lender_dashboard", current_path
  end

  test "authenticated lender sees loan history on dashboard" do
    create_roles_borrower_project_and_lender
    visit root_path
    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
    assert page.has_content?("Loans Made")
  end
end
