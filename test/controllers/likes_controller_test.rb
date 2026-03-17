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
  end

  test 'should not create like when already liked' do
    sign_in @user
    # Создаем лайк через контроллер, чтобы избежать дублирования
    post post_likes_path(@post)

    assert_no_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to @post
  end

  test 'should not create like when not signed in' do
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should destroy like when signed in' do
    sign_in @user
    post post_likes_path(@post) # Создаем лайк через POST

    assert_difference('PostLike.count', -1) do
      delete post_like_path(@post, 0) # id не важен
    end
    assert_redirected_to @post
  end

  test 'should not destroy like when not signed in' do
    sign_in @user
    post post_likes_path(@post)  # Создаем лайк через POST
    sign_out @user

    assert_no_difference('PostLike.count') do
      delete post_like_path(@post, 0)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should not destroy like by other user' do
    sign_in @other_user
    post post_likes_path(@post)  # Другой пользователь создает лайк
    sign_out @other_user

    sign_in @user
    assert_no_difference('PostLike.count') do
      delete post_like_path(@post, 0)
    end
    assert_redirected_to @post
  end
end
