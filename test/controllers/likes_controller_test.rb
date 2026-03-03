# test/controllers/likes_controller_test.rb
# frozen_string_literal: true

require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post = posts(:one)
  end

  test "should not create like when not signed in" do
    assert_no_difference("PostLike.count") do
      post post_likes_path(@post)
    end
    assert_redirected_to new_user_session_url
  end

  test "should create like when signed in" do
    sign_in @user
    assert_difference("PostLike.count", 1) do
      post post_likes_path(@post)
    end
    assert_redirected_to @post

    like = PostLike.last
    assert_equal @user.id, like.user_id
    assert_equal @post.id, like.post_id
  end

  test "should not create duplicate like" do
    sign_in @user
    post post_likes_path(@post)

    assert_no_difference("PostLike.count") do
      post post_likes_path(@post)
    end
    assert_redirected_to @post
  end

  test "should destroy like when signed in as owner" do
    sign_in @user
    post post_likes_path(@post)
    like = PostLike.last

    assert_difference("PostLike.count", -1) do
      delete post_like_path(@post, like)
    end
    assert_redirected_to @post
  end

  test "should not destroy like when not signed in" do
    sign_in @user
    post post_likes_path(@post)
    like = PostLike.last

    sign_out @user

    assert_no_difference("PostLike.count") do
      delete post_like_path(@post, like)
    end
    assert_redirected_to new_user_session_url
  end

  test "should not destroy like by other user" do
    sign_in @user
    post post_likes_path(@post)
    like = PostLike.last

    sign_in @other_user

    assert_raises(ActiveRecord::RecordNotFound) do
      delete post_like_path(@post, like)
    end
  end
end
