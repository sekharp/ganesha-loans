require 'test_helper'

class GuestCanViewASpecificProjectTest < ActionDispatch::IntegrationTest
  test "guest can view a specific project" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project

    visit '/projects'
    click_button 'Learn More'

    assert_equal '/john-doe/projects/buy-me-a-goat', current_path

    within '.project-info' do
      assert page.has_content? 'Buy me a goat'
      assert page.has_content? 'Mostly goat purchases'
      assert page.has_content? '$1,000.00'
      assert page.has_content? 'Amount Loaned: $0'
    end

    within '.borrower-info' do
      assert page.has_content? 'John Doe'
    end

    within '.lend-btn' do
      assert page.has_link? 'Lend'
    end

    assert page.has_link? 'Return to Projects'
  end
end
