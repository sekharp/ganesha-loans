require 'test_helper'

class RegisteredBorrowerCreatesProjectTest < ActionDispatch::IntegrationTest
  test "registered borrower creates a project" do
    create_roles
    create_categories
    create_borrower
    visit "/"
    click_link "Login"
    within(".login-form") do
      fill_in "Username", with: "jdoe"
      fill_in "Password", with: "password"
      click_button "Login"
    end
    current_user = User.last
    assert_equal "/borrower_dashboard", current_path
    click_button "Create A New Project"

    assert_equal "/borrower_projects/new", current_path

    fill_in "Title", with: "Test Project"
    fill_in "Goal amount", with: 3500
    fill_in "Description", with: "Test Project Description"
    click_button "Create Project"

    assert_equal "/borrower_dashboard", current_path
    assert_equal 1, current_user.projects.count
    assert page.has_content?("Test Project")
    assert page.has_content?("Pending")
    assert page.has_content?("$3,500.00")
    assert page.has_content?("Test Project Description")
  end

  test "registered borrower cannot create a project with invalid data" do
    create_roles
    create_borrower
    visit "/"
    click_link "Login"
    within(".login-form") do
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"
    end
    current_user = User.last
    assert_equal "/borrower_dashboard", current_path
    click_button "Create A New Project"

    assert_equal "/borrower_projects/new", current_path

    fill_in "Goal amount", with: 123

    click_button "Create Project"

    assert page.has_content?("Something went wrong. Make sure you fill out all fields.")
    assert_equal "/borrower_projects/new", current_path
  end
end
