require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def create_project
    Project.create!(title:       "my project",
                    description: "my description",
                    user_id:     1,
                    goal_amount: 200)
  end

  test "a new cart has no contents" do
    expected = {}
    assert_equal expected, Cart.new(nil).contents
  end

  test "add_project adds project_id and amount to contents" do
    cart = Cart.new(nil)
    project_id = 1
    loan_amount = 200

    cart.add_project(project_id, loan_amount)

    expected = {"1" => 200}

    assert_equal expected, cart.contents
  end

  test "update_loan adjusts loan amount for project" do
    cart = Cart.new({"1" => 200})
    cart.update_loan(1, 205)

    expected = {"1" => 205}

    assert_equal expected, cart.contents
  end

  test "update_loan removes project from cart if amount drops below 1" do
    cart = Cart.new({"1" => 200})
    cart.update_loan(1, 0)

    expected = {}

    assert_equal expected, cart.contents
  end

  test "remove_project removes project with id from cart" do
    cart = Cart.new({"1" => 200})
    cart.remove_project(1)

    expected = {}

    assert_equal expected, cart.contents
  end

  test "total_count returns the number of projects in the cart" do
    cart = Cart.new({"1" => 200,
                     "2" => 300})

    assert_equal 2, cart.total_count
  end

  test "total_amount returns the total amount of all loans in the cart" do
    cart = Cart.new({"1" => 200,
                     "2" => 300})

    assert_equal 500, cart.total_amount
  end

  test "amount_of returns the amount of a loan for a given project" do
    cart = Cart.new({"1" => 200,
                     "2" => 300})

    assert_equal 300, cart.amount_of(2)
  end

  test "projects returns CartProjects for each project in cart" do
    project = create_project
    cart = Cart.new(nil)
    cart.add_project(project.id, 200)
    cart_project = cart.projects.first

    assert_equal 200, cart_project.amount
    assert_equal "my project", cart_project.title
  end
end
