require 'test_helper'

class ProjectImageLinksToProjectTest < ActionDispatch::IntegrationTest
  test "project image links to project path" do
    create_roles
    borrower = create_borrower
    borrower.projects << create_project
    visit "/"

    first('.card').find(".image-link").click
    assert_equal "/john-doe/projects/buy-me-a-goat", current_path
  end
end
