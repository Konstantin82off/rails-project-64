# frozen_string_literal: true

require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = post_comments(:one)
  end

  test "should create comment when signed in" do
    sign_in @user
    assert_difference("PostComment.count") do
      post post_comments_path(@post), params: { post_comment: { content: "New comment" } }
    end
    assert_redirected_to @post
  end

  test "should not create comment when not signed in" do
    assert_no_difference("PostComment.count") do
      post post_comments_path(@post), params: { post_comment: { content: "New comment" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should create reply comment" do
    sign_in @user
    assert_difference("PostComment.count") do
      post post_comments_path(@post), params: {
        post_comment: {
          content: "Reply comment",
          parent_id: @comment.id
        }
      }
    end
    assert_redirected_to @post
  end

  test "should destroy own comment" do
    sign_in @user
    assert_difference("PostComment.count", -1) do
      delete post_comment_path(@post, @comment)
    end
    assert_redirected_to @post
  end

  test "should not destroy someone else's comment" do
    sign_in users(:two)
    assert_no_difference("PostComment.count") do
      delete post_comment_path(@post, @comment)
    end
    assert_redirected_to @post
  end
end
