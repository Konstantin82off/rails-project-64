# frozen_string_literal: true

require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should create like when signed in" do
    sign_in @user
    assert_difference("PostLike.count") do
      post post_like_path(@post)  # было post_likes_path
    end
    assert_redirected_to @post
  end

  test "should not create like when not signed in" do
    assert_no_difference("PostLike.count") do
      post post_like_path(@post)  # было post_likes_path
    end
    assert_redirected_to new_user_session_path
  end

  test "should destroy own like" do
    sign_in @user
    @post.post_likes.create(user: @user)
    assert_difference("PostLike.count", -1) do
      delete post_like_path(@post)  # было post_like_path (это правильно)
    end
    assert_redirected_to @post
  end

  test "should not destroy like when not signed in" do
    @post.post_likes.create(user: @user)
    assert_no_difference("PostLike.count") do
      delete post_like_path(@post)  # было post_like_path (это правильно)
    end
    assert_redirected_to new_user_session_path
  end
end
