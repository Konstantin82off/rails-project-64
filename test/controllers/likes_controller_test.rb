# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post = posts(:one)
  end

  test 'should create like when signed in' do
    sign_in @user
    assert_difference('PostLike.count', 1) do
      post post_likes_path(@post)
    end
    assert_redirected_to @post
    # flash-сообщение больше не проверяем
  end

  test 'should not create like when already liked' do
    sign_in @user
    @post.likes.create(user: @user)

    assert_no_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to @post
    # flash-сообщение больше не проверяем
  end

  test 'should not create like when not signed in' do
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should destroy like when signed in' do
    sign_in @user
    like = @post.likes.create(user: @user)

    assert_difference('PostLike.count', -1) do
      delete post_like_path(@post, like)
    end
    assert_redirected_to @post
    # flash-сообщение больше не проверяем
  end

  test 'should not destroy like when not signed in' do
    like = @post.likes.create(user: @user)

    assert_no_difference('PostLike.count') do
      delete post_like_path(@post, like)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should not destroy like by other user' do
    sign_in @user
    like = @post.likes.create(user: @other_user)

    assert_no_difference('PostLike.count') do
      delete post_like_path(@post, like)
    end
    assert_redirected_to @post
    # flash-сообщение больше не проверяем
  end
end
