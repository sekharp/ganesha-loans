require 'test_helper'

class RegisteredBorrowerLogsInTest < ActionDispatch::IntegrationTest
  test "borrower can login" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

  test "logged in borrower sees project details" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_pending_project

    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    assert page.has_content?("Your Current Projects")
    assert page.has_content?("Project Title: Pending goat project")
    assert page.has_content?("Goal Amount: $22,000.00")
    assert page.has_content?("Total Loans Received: $0")
    assert page.has_content?("Percent Funded: 0%")
    assert page.has_content?("Project Status: Pending")
  end

  test "logged in borrower can edit profile data" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    click_button "Edit Profile"

    fill_in 'Username', with: 'cmejia'
    fill_in 'First name', with: 'Chaim'
    fill_in 'Last name', with: 'Mejia'
    fill_in 'Password', with: 'password'
    fill_in 'Street address', with: '123 example st.'
    fill_in 'City', with: 'Examplesburg'
    fill_in 'State', with: 'EX'
    fill_in 'Zip', with: '12345'

    click_button 'Update Profile'

    assert page.has_content? 'Username: cmejia'
    assert page.has_content? 'First name: Chaim'
    assert page.has_content? 'Last name: Mejia'
    assert page.has_content? 'Street address: 123 example st.'
    assert page.has_content? 'City: Examplesburg'
    assert page.has_content? 'State: EX'
    assert page.has_content? 'Zip: 12345'
  end

  test "logged in borrower cannot edit profile data with invalid password" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    click_button "Edit Profile"

    fill_in 'Username', with: 'cmejia'
    fill_in 'First name', with: 'Chaim'
    fill_in 'Last name', with: 'Mejia'
    fill_in 'Street address', with: '123 example st.'
    fill_in 'City', with: 'Examplesburg'
    fill_in 'State', with: 'EX'
    fill_in 'Zip', with: '12345'

    click_button 'Update Profile'

    assert page.has_content? 'Please enter your password'
  end

  test "logged in borrower can become a lender" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path

    click_button "Become a Lender"

    assert_equal "/lender_dashboard", current_path
  end
end
