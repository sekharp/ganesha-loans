require 'test_helper'

class GuestCanViewProjectsIndexTest < ActionDispatch::IntegrationTest
  test "guest can view projects index" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project

    visit "/"
    within "#primary-navigation" do
      click_link("Lend")
    end

    assert_equal "/projects", current_path
    assert page.has_content?("Buy me a goat")
  end

  test "guest cannot view unapproved projects" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project
    borrower.projects << create_pending_project

    visit "/"

    assert page.has_content?("Buy me a goat")
    refute page.has_content?("Pending goat project")
    refute page.has_content?("22000")
    refute page.has_content?("Eventually goat purchase, once this is approved")

    within "#primary-navigation" do
      click_link("Lend")
    end

    assert_equal "/projects", current_path
    assert page.has_content?("Buy me a goat")
    refute page.has_content?("Pending goat project")
    refute page.has_content?("22000")
    refute page.has_content?("Eventually goat purchase, once this is approved")
  end
end
