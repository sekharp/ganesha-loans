require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  def valid_role
    Role.new(name: 'example')
  end

  test "it is valid" do
    assert valid_role.valid?
  end

  test "it is invalid without a name" do
    role = valid_role
    role.name = nil

    refute role.valid?
  end

  test "it is invalid without a unique name" do
    valid_role.save
    role = Role.new(name: 'example')

    refute role.valid?
  end
end
