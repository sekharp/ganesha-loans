require 'test_helper'

class ProjectIndexViewTest < ActionDispatch::IntegrationTest
  test "project index view test" do
    create_roles_borrower_project_and_lender
    visit "/projects"

  end
end
