require 'test_helper'

class GuestCanUpdateCartLoanAmountTest < ActionDispatch::IntegrationTest
  test 'guest can update cart loan amount' do
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    visit '/cart'

    assert page.has_content? '$200.00'

    within '.loan' do
      fill_in 'Amount', with: 100
      click_button 'Update'
    end

    assert_equal '/cart', current_path
    assert page.has_content? '$100.00'
  end

  test 'guest cannot update cart loan amount with invalid amount' do
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    visit '/cart'

    assert page.has_content? '$200.00'

    within '.loan' do
      fill_in 'Amount', with: 38219012381093823901823018
      click_button 'Update'
    end

    assert_equal '/cart', current_path
    assert page.has_content? "Sorry! That's not a valid loan amount."
  end
end
