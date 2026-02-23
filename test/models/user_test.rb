# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(
      email: Faker::Internet.email,
      name: Faker::Name.name
    )
    assert { user.valid? }
  end

  test "should be invalid without email" do
    user = User.new(email: nil)
    assert { !user.valid? }
  end

  test "should save user with valid data" do
    user = User.new(
      email: Faker::Internet.email,
      name: Faker::Name.name
    )
    assert { user.save }
  end
end
