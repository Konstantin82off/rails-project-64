# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post_with_like_by_user = posts(:one)      # пост с лайком от user one
    @post_with_like_by_other = posts(:two)     # пост с лайком от user two
    @post_without_likes = posts(:two)          # для создания
  end

  test 'should create like when signed in' do
    sign_in @user
    assert_difference('PostLike.count', 1) do
      post post_likes_path(@post_without_likes)
    end
    assert_redirected_to @post_without_likes
  end

  test 'should not create like when already liked' do
    sign_in @user
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post_with_like_by_user)
    end
    assert_redirected_to @post_with_like_by_user
  end

  test 'should not create like when not signed in' do
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post_without_likes)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should destroy like when signed in' do
    sign_in @user
    assert_difference('PostLike.count', -1) do
      delete post_like_path(@post_with_like_by_user, 0)
    end
    assert_redirected_to @post_with_like_by_user
  end

  test 'should not destroy like when not signed in' do
    assert_no_difference('PostLike.count') do
      delete post_like_path(@post_with_like_by_user, 0)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should not destroy like by other user' do
    sign_in @user # user one пытается удалить лайк user two
    assert_no_difference('PostLike.count') do
      delete post_like_path(@post_with_like_by_other, 0)
    end
    assert_redirected_to @post_with_like_by_other
  end
end
