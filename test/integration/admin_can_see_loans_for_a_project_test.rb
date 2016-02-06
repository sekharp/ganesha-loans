require 'test_helper'

class AdminCanSeeLoansForAProjectTest < ActionDispatch::IntegrationTest
  test 'admin can see loans for a project' do
    create_admin
    login_admin

    borrower = create_borrower
    lender = create_lender
    project = create_project

    borrower.projects << project
    create_loan(project, lender, 200)

    visit '/admin/dashboard'
    click_link 'Buy me a goat'

    assert_equal '/admin/projects/buy-me-a-goat', current_path
    within '.loans' do
      assert page.has_content? 'Matt Doe'
      assert page.has_content? 'Amount: $200.00'
    end
  end
end
