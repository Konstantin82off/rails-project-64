# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    sign_in @user
    assert_difference("Post.count") do
      post posts_url, params: { post: { title: "New Post", body: "Body of new post" } }
    end
    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end
end
