require 'test_helper'

class AdminCanCreatCategoryTest < ActionDispatch::IntegrationTest
  test 'admin can create a category' do
    create_admin
    login_admin
    click_link 'Admin Dashboard'
    click_link 'Categories'

    assert_equal '/admin/categories', current_path
    within '.categories' do
      refute page.has_content? 'My Category'
    end

    click_link 'Create Project Category'

    assert_equal '/admin/categories/new', current_path
    within '.new_category' do
      fill_in 'Title', with: 'My Category'
      click_button 'Submit'
    end

    assert_equal '/admin/categories', current_path
    within '.categories' do
      assert page.has_content? 'My Category'
    end
  end

  test 'admin cannot create a category without a title' do
    create_admin
    login_admin
    click_link 'Admin Dashboard'
    click_link 'Categories'

    assert_equal '/admin/categories', current_path
    within '.categories' do
      refute page.has_content? 'My Category'
    end

    click_link 'Create Project Category'

    assert_equal '/admin/categories/new', current_path
    within '.new_category' do
      click_button 'Submit'
    end

    assert_equal '/admin/categories/new', current_path
    assert page.has_content? "Something went wrong. Please enter a title."
  end
end
