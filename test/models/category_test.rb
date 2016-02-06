require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def valid_category
    Category.new(title: "a category")
  end

  test "it is valid" do
    assert valid_category.valid?
  end

  test "it is invalid without a title" do
    category = valid_category
    category.title = nil

    refute category.valid?
  end

  test "it has a slug" do
    category = valid_category

    assert_equal "a-category", category.to_slug
  end

  test "it responds to projects" do
    assert valid_category.respond_to? :projects
  end
end
