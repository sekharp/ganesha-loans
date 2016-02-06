require 'test_helper'

class GuestWithCartLogsInTest < ActionDispatch::IntegrationTest
  test 'guest with cart logs in' do
    create_roles
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)
    create_lender

    visit '/cart'
    click_button 'Checkout'

    assert_equal '/login', current_path

    fill_in 'Username', with: 'mdoe'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    assert_equal '/cart', current_path
  end
end
