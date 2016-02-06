require 'test_helper'

class GuestViewsThreeTopProjectsOnHomepageTest < ActionDispatch::IntegrationTest
  test "guest sees three top projects on homepage" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project
    visit "/"

    assert page.has_content?("Featured Projects")
    assert page.has_content?("micro-lending platform")
  end
end
