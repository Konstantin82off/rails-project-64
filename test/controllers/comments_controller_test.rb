# frozen_string_literal: true

require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post = posts(:one)
  end

  test "should not create comment when not signed in" do
    assert_no_difference("PostComment.count") do
      post post_comments_path(@post), params: { post_comment: { content: "Test comment" } }
    end
    assert_redirected_to new_user_session_url
  end

  test "should create comment when signed in" do
    sign_in @user
    assert_difference("PostComment.count", 1) do
      post post_comments_path(@post), params: { post_comment: { content: "Test comment" } }
    end
    assert_redirected_to @post

    comment = PostComment.last
    assert_equal @user.id, comment.user_id
    assert_equal @post.id, comment.post_id
    assert_equal "Test comment", comment.content
  end

  test "should create nested comment" do
    sign_in @user
    parent = @post.post_comments.create!(user: @user, content: "Parent comment")

    assert_difference("PostComment.count", 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: "Nested comment",
          parent_id: parent.id
        }
      }
    end
    assert_redirected_to @post

    comment = PostComment.last
    assert_not_nil comment.ancestry
    assert comment.ancestry.include?(parent.id.to_s)
  end

  test "should destroy own comment" do
    sign_in @user
    comment = @post.post_comments.create!(user: @user, content: "Test comment")

    assert_difference("PostComment.count", -1) do
      delete post_comment_path(@post, comment)
    end
    assert_redirected_to @post
  end

  test "should not destroy someone else's comment" do
    sign_in @user
    comment = @post.post_comments.create!(user: @other_user, content: "Test comment")

    assert_no_difference("PostComment.count") do
      delete post_comment_path(@post, comment)
    end
    assert_redirected_to @post
  end

  test "should not destroy comment when not signed in" do
    comment = @post.post_comments.create!(user: @user, content: "Test comment")

    assert_no_difference("PostComment.count") do
      delete post_comment_path(@post, comment)
    end
    assert_redirected_to new_user_session_url
  end
end
