require 'test_helper'

class CartProjectTest < ActiveSupport::TestCase
  def new_project
    Project.new(title:       "my project",
                description: "my description",
                user_id:     1,
                goal_amount: 200)
  end

  test "it has a project" do
    project = new_project
    cart_project = CartProject.new(project, 100)

    assert_equal project, cart_project.project
  end

  test "it has an amount" do
    project = new_project
    cart_project = CartProject.new(project, 100)

    assert_equal 100, cart_project.amount
  end

  test "it has a default amount of zero" do
    project = new_project
    cart_project = CartProject.new(project)

    assert_equal 0, cart_project.amount
  end
end
