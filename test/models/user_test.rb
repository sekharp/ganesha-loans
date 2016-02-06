require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def valid_user
    User.new({ username:   "pat",
               password:   "password",
               first_name: "pat",
               last_name:  "wey"})
  end

  def create_role(name)
    Role.create!(name: name)
  end

  test "it is valid" do
    assert valid_user.valid?
  end

  test "it is invalid without username" do
    user = valid_user
    user.username = nil

    refute user.valid?
  end

  test "it is invalid without password" do
    user = valid_user
    user.password = nil

    refute user.valid?
  end

  test "it is invalid without first_name" do
    user = valid_user
    user.first_name = nil

    refute user.valid?
  end

  test "it is invalid without last_name" do
    user = valid_user
    user.last_name = nil

    refute user.valid?
  end

  test "it must have a unique username" do
    valid_user.save
    same_user = User.new({username: "pat",
                          password: "DIFFERENT",
                          first_name: "DIFFERENT",
                          last_name: "DIFFERENT"})

    refute same_user.valid?
  end

  test "it responds to loans" do
    assert valid_user.respond_to? :loans
  end

  test "it responds to projects" do
    assert valid_user.respond_to? :projects
  end

  test "it responds to roles" do
    assert valid_user.respond_to? :roles
  end

  test "it has a slug" do
    assert_equal "pat-wey", valid_user.set_slug
  end

  test "it has a full name" do
    assert_equal "pat wey", valid_user.full_name
  end

  test "it is an admin with an admin role" do
    valid_user.save
    user = User.first
    user.roles << create_role("admin")

    assert user.admin?
  end

  test "it is a borrower with a borrower role" do
    valid_user.save
    user = User.first
    user.roles << create_role("borrower")

    assert user.borrower?
  end

   test "it is a lender with an lender role" do
    valid_user.save
    user = User.first
    user.roles << create_role("lender")

    assert user.lender?
  end


end
