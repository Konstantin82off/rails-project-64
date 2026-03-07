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
    assert { response.redirect? }
    assert { response.location == new_user_session_url }
  end

  test "should create comment when signed in" do
    sign_in @user
    assert_difference("PostComment.count", 1) do
      post post_comments_path(@post), params: { post_comment: { content: "Test comment" } }
    end
    assert { response.redirect? }
    assert { response.location == post_url(@post) }

    comment = PostComment.last
    assert { comment.user_id == @user.id }
    assert { comment.post_id == @post.id }
    assert { comment.content == "Test comment" }
  end

  test "should create nested comment" do
    sign_in @user
    parent = @post.comments.create!(user: @user, content: "Parent comment")

    assert_difference("PostComment.count", 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: "Nested comment",
          parent_id: parent.id
        }
      }
    end
    assert { response.redirect? }
    assert { response.location == post_url(@post) }

    comment = PostComment.last
    assert { !comment.ancestry.nil? }
    assert { comment.ancestry.include?(parent.id.to_s) }
  end

  test "should destroy own comment" do
    sign_in @user
    comment = @post.comments.create!(user: @user, content: "Test comment")

    assert_difference("PostComment.count", -1) do
      delete post_comment_path(@post, comment)
    end
    assert { response.redirect? }
    assert { response.location == post_url(@post) }
  end

  test "should not destroy someone else's comment" do
    sign_in @user
    comment = @post.comments.create!(user: @other_user, content: "Test comment")

    assert_no_difference("PostComment.count") do
      delete post_comment_path(@post, comment)
    end
    assert { response.redirect? }
    assert { response.location == post_url(@post) }
  end

  test "should not destroy comment when not signed in" do
    comment = @post.comments.create!(user: @user, content: "Test comment")

    assert_no_difference("PostComment.count") do
      delete post_comment_path(@post, comment)
    end
    assert { response.redirect? }
    assert { response.location == new_user_session_url }
  end
end
