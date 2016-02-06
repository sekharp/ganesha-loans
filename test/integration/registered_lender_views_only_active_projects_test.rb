require 'test_helper'

class RegisteredLenderViewsOnlyActiveProjectsTest < ActionDispatch::IntegrationTest
  test "lender can view projects index" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project
    create_lender
    visit login_path

    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    visit "/"
    assert page.has_content?("Logout")

    within "#primary-navigation" do
      click_link("Lend")
    end

    assert_equal "/projects", current_path
    assert page.has_content?("Buy me a goat")
  end

  test "lender cannot view unapproved projects" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project
    borrower.projects << create_pending_project
    create_lender
    visit login_path

    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Logout")

    visit "/"

    assert page.has_content?("Buy me a goat")
    refute page.has_content?("Pending goat project")
    refute page.has_content?("22000")
    refute page.has_content?("Eventually goat purchase, once this is approved")

    within "#primary-navigation" do
      click_link("Lend")
    end

    assert_equal "/projects", current_path
    assert page.has_content?("Buy me a goat")
    refute page.has_content?("Pending goat project")
    refute page.has_content?("22000")
    refute page.has_content?("Eventually goat purchase, once this is approved")
  end
end
