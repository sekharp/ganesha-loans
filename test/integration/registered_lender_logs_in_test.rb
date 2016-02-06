require 'test_helper'

class RegisteredBorrowerLogsInTest < ActionDispatch::IntegrationTest
  test "logged in lender can edit profile data" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
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

  test "logged in lender can become a borrower" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path

    click_button "Become a Borrower"

    assert_equal "/borrower_dashboard", current_path
  end

  test "combined user can edit profile data" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path

    click_button "Become a Borrower"

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

    assert_equal "/borrower_dashboard", current_path

    assert page.has_content? 'Username: cmejia'
    assert page.has_content? 'First name: Chaim'
    assert page.has_content? 'Last name: Mejia'
    assert page.has_content? 'Street address: 123 example st.'
    assert page.has_content? 'City: Examplesburg'
    assert page.has_content? 'State: EX'
    assert page.has_content? 'Zip: 12345'
  end
end
