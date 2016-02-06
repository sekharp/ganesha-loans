require 'test_helper'

class LenderMakesLoanTest < ActionDispatch::IntegrationTest
  test 'lender makes loan' do
    create_roles
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    lender = create_lender
    login_lender

    visit '/cart'
    click_button 'Checkout'

    assert_equal '/lender_dashboard', current_path
    assert lender.loans.count == 1

    within '#primary-navigation' do
      assert page.has_content? '0'
    end

    within '#nav-bar' do
      assert page.has_content? 'Loan submitted'
    end
  end

  test 'lender makes loan to multiple projects' do
    create_roles
    borrower = create_borrower
    project = create_project
    borrower.projects << project
    add_project_to_cart(project)

    borrower_b = User.create!(first_name: 'Chaim',
                              last_name:  'Mejia',
                              username:   'cmejia',
                              password:   'password')
    project_b = Project.create!(goal_amount: 5000,
                                title:       "Buy me a boat",
                                description: "I'm on a boat")
    borrower_b.projects << project_b
    add_project_to_cart(project_b)

    lender = create_lender
    login_lender

    visit '/cart'
    click_button 'Checkout'

    assert_equal '/lender_dashboard', current_path
    assert lender.loans.count == 2

    within '#primary-navigation' do
      assert page.has_content? '0'
    end

    within '#nav-bar' do
      assert page.has_content? 'Loan submitted'
    end
  end

  test 'lender cannot checkout with no loans in cart' do
    create_roles
    borrower = create_borrower
    project = create_project
    borrower.projects << project

    lender = create_lender
    login_lender

    visit '/cart'
    click_button 'Checkout'

    assert_equal '/cart', current_path
    assert page.has_content? "No loans in cart. Don't you want to loan money?"
  end

end
