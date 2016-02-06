require 'test_helper'

class GuestCanRemoveLoanFromCartTest < ActionDispatch::IntegrationTest
  test 'guest can remove loan from cart' do
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    visit '/cart'
    assert page.has_content? 'Buy me a goat'

    within '.loan' do
      click_link 'Remove'
    end

    assert_equal '/cart', current_path
    refute page.has_css? '.loan'
  end
end
