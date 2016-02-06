require 'test_helper'

class GuestWithCartCannotCheckOutTest < ActionDispatch::IntegrationTest
  test 'guest with cart cannot check out' do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project

    visit '/cart'
    click_button 'Checkout'

    within '#nav-bar' do
      assert page.has_content? "Please log in or create an account before checking out"
    end

    assert_equal '/login', current_path
  end
end
