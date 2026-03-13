# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post = posts(:one)
    @category = categories(:one)
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new when signed in' do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test 'should not get new when not signed in' do
    get new_post_url
    assert_redirected_to new_user_session_path
  end

  test 'should create post when signed in' do
    sign_in @user
    assert_difference('Post.count', 1) do
      post posts_url, params: { post: { title: 'New Post', body: 'Body text', category_id: @category.id } }
    end
    assert_redirected_to post_path(Post.last)
  end

  test 'should not create post when not signed in' do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { title: 'New Post', body: 'Body text', category_id: @category.id } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should not create post with invalid data' do
    sign_in @user
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { title: '', body: '', category_id: nil } }
    end
    assert_response :unprocessable_entity
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end
