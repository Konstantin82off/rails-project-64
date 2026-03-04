# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @category = categories(:one)
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new when signed in" do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test "should not get new when not signed in" do
    get new_post_url
    assert_redirected_to new_user_session_url
  end

  test "should create post when signed in" do
    sign_in @user
    assert_difference("Post.count", 1) do
      post posts_url, params: { post: {
        title: "New Post",
        body: "Body of new post",
        category_id: @category.id
      } }
    end
    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should show post with comments using correct routes" do
    sign_in @user
    get post_url(@post)
    assert_response :success

    assert_select "form[action=?]", post_comments_path(@post)
  end

  test "should not create post when not signed in" do
    assert_no_difference("Post.count") do
      post posts_url, params: { post: {
        title: "New Post",
        body: "Body of new post",
        category_id: @category.id
      } }
    end
    assert_redirected_to new_user_session_url
  end

  test "should get edit when signed in as owner" do
    sign_in @user
    get edit_post_url(@post)
    assert_response :success
  end

  test "should not get edit when not signed in" do
    get edit_post_url(@post)
    assert_redirected_to new_user_session_url
  end

  test "should not get edit when signed in as other user" do
    sign_in @other_user
    get edit_post_url(@post)
    assert_redirected_to posts_url
  end

  test "should update post when signed in as owner" do
    sign_in @user
    patch post_url(@post), params: { post: { title: "Updated Title" } }
    assert_redirected_to post_url(@post)
    @post.reload
    assert_equal "Updated Title", @post.title
  end

  test "should not update post when not signed in" do
    patch post_url(@post), params: { post: { title: "Updated Title" } }
    assert_redirected_to new_user_session_url
    @post.reload
    assert_not_equal "Updated Title", @post.title
  end

  test "should not update post when signed in as other user" do
    sign_in @other_user
    patch post_url(@post), params: { post: { title: "Updated Title" } }
    assert_redirected_to posts_url
    @post.reload
    assert_not_equal "Updated Title", @post.title
  end

  test "should destroy post when signed in as owner" do
    sign_in @user
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end

  test "should not destroy post when not signed in" do
    assert_no_difference("Post.count") do
      delete post_url(@post)
    end
    assert_redirected_to new_user_session_url
  end

  test "should not destroy post when signed in as other user" do
    sign_in @other_user
    assert_no_difference("Post.count") do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end
end
