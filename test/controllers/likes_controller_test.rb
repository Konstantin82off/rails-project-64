# test/controllers/likes_controller_test.rb
# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post = posts(:one)
    @post_without_likes = posts(:two) # Пост без лайков в фикстурах
  end

  test 'should create like when signed in' do
    sign_in @user
    assert_difference('PostLike.count', 1) do
      post post_likes_path(@post_without_likes) # Используем пост без лайков
    end
    assert_redirected_to @post_without_likes
  end

  test 'should not create like when already liked' do
    sign_in @user
    # @post уже имеет лайк от user one в фикстурах
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post) # Пытаемся создать дубликат
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
    # @post уже имеет лайк от user one в фикстурах
    assert_difference('PostLike.count', -1) do
      delete post_like_path(@post, 0)
    end
    assert_redirected_to @post
  end

  test 'should not destroy like when not signed in' do
    # Лайк существует в фикстурах
    assert_no_difference('PostLike.count') do
      delete post_like_path(@post, 0)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should not destroy like by other user' do
    sign_in @other_user # У other_user есть лайк на post two в фикстурах
    assert_no_difference('PostLike.count') do
      delete post_like_path(posts(:two), 0) # Пытаемся удалить чужой лайк
    end
    assert_redirected_to posts(:two)
  end
end
