require 'test_helper'

class CombinedUserTest < ActionDispatch::IntegrationTest
  test 'combined user registers and has both roles' do
    create_roles
    combined_user = create_borrower
    combined_user.roles << Role.find_by(name: "lender")

    assert combined_user.lender?
    assert combined_user.borrower?
  end

  test 'combined user has permissions for borrower and lender' do
    create_roles
    combined_user = create_borrower
    combined_user.roles << Role.find_by(name: "lender")

    assert combined_user.lender?
    assert combined_user.borrower?

    visit root_path

    click_link "Login"
    fill_in "Username", with: "jdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/borrower_dashboard", current_path
    click_button "Lender Profile"
    assert_equal "/lender_dashboard", current_path
  end
end
