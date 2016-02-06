require 'test_helper'

class UserCannotViewOtherUsersLoansTest < ActionDispatch::IntegrationTest
  test "user can only see his or her past loans" do
    lender = create_lender
    lender_two = User.create!(first_name: 'Jane',
                              last_name:  'Doe',
                              username:   'janedoe',
                              password:   'password',
                              bio: 'my bio')
    lender_two.roles << Role.find_by(name: "lender")
    borrower = create_borrower
    project = create_project
    borrower.projects << project

    loan = project.loans.create!(amount: 500, user_id: lender.id)
    loan = project.loans.create!(amount: 1800, user_id: lender_two.id)

    visit root_path
    click_link "Login"

    fill_in "Username", with: "janedoe"
    fill_in "Password", with: "password"
    click_button "Login"

    visit lender_dashboard_path

    assert page.has_content?("Lender Profile")
    assert page.has_content?("Username: janedoe")
    assert page.has_content?("Loans Made")

    assert page.has_content?("Buy me a goat")
    assert page.has_content?("$1,800.00 ")
    refute page.has_content?("$500.00")
  end
end
