require 'test_helper'

class GuestCanAddAProjectToTheirCartTest < ActionDispatch::IntegrationTest
  test "guest can add a project to their cart" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project

    visit "/"
    click_button "Learn More"

    assert_equal "/john-doe/projects/buy-me-a-goat", current_path
    within(".lend-btn") do
      click_link "Lend"
    end

    assert_equal "/john-doe/cart_projects/new", current_path

    fill_in "Amount", with: "200"

    within(".lend-form") do
      click_button "Lend!"
    end

    within "#primary-navigation" do
      assert page.has_content? "1"
    end

    within "#nav-bar" do
      assert page.has_content? 'Added Buy me a goat loan to your cart.'
    end

    assert_equal "/cart", current_path
  end

  test "guest can add multiple borrowers' projects to their cart" do
    create_roles
    borrower = User.create!(first_name: 'Chaim',
                            last_name:  'Mejia',
                            username:   'cmejia',
                            password:   'password')
    project = Project.create!(goal_amount: 5000,
                              title:       "Buy me a boat",
                              description: "I'm on a boat")
    borrower.projects << project
    add_project_to_cart(project)

    borrower_b = create_borrower
    project_b = create_project
    borrower_b.projects << project_b

    add_project_to_cart(project_b)

    within '#primary-navigation' do
      assert page.has_content? '2'
    end

    within '#nav-bar' do
      assert page.has_content? 'Added Buy me a goat loan to your cart.'
    end
    assert_equal '/cart', current_path
  end

  test 'guest cannot add a project to their cart with invalid loan amount' do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project

    visit "/john-doe/projects/buy-me-a-goat"
    within(".lend-btn") do
      click_link "Lend"
    end

    fill_in 'Amount', with: '-2'

    within('.lend-form') do
      click_button 'Lend!'
    end

    assert_equal '/john-doe/cart_projects/new', current_path
    within '#primary-navigation' do
      refute page.has_content? '1'
    end
    within '#nav-bar' do
      assert page.has_content? 'Please enter a valid amount'
    end
  end
end
