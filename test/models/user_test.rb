# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(
      email: Faker::Internet.email,
      name: Faker::Name.name,
      password: "password123",
      password_confirmation: "password123"
    )
    assert { user.valid? }
  end

  test "should be invalid without email" do
    user = User.new(
      email: nil,
      name: Faker::Name.name,
      password: "password123",
      password_confirmation: "password123"
    )
    assert { !user.valid? }
    assert { user.errors[:email].any? }
  end

  test "should save user with valid data" do
    user = User.new(
      email: Faker::Internet.email,
      name: Faker::Name.name,
      password: "password123",
      password_confirmation: "password123"
    )
    assert { user.save }
  end
end
