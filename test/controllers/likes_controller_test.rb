# frozen_string_literal: true

require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @post_without_like = posts(:two)
    @post_with_like = posts(:one)
  end

  test "should not create like when not signed in" do
    assert_no_difference("PostLike.count") do
      post post_likes_path(@post_without_like)
    end
    assert { response.redirect? }
    assert { response.location == new_user_session_url }
  end

  test "should create like when signed in" do
    sign_in @user
    assert_difference("PostLike.count", 1) do
      post post_likes_path(@post_without_like)
    end
    assert { response.redirect? }
    assert { response.location == post_url(@post_without_like) }

    like = PostLike.last
    assert { like.user_id == @user.id }
    assert { like.post_id == @post_without_like.id }
  end

  test "should not create duplicate like" do
    sign_in @user
    post post_likes_path(@post_with_like)

    assert_no_difference("PostLike.count") do
      post post_likes_path(@post_with_like)
    end
    assert { response.redirect? }
    assert { response.location == post_url(@post_with_like) }
  end

  test "should destroy like when signed in as owner" do
    sign_in @user
    like = post_likes(:one)

    assert_difference("PostLike.count", -1) do
      delete post_like_path(like.post, like)
    end
    assert { response.redirect? }
    assert { response.location == post_url(like.post) }
    assert { !PostLike.exists?(like.id) }
  end

  test "should not destroy like when not signed in" do
    like = post_likes(:one)

    assert_no_difference("PostLike.count") do
      delete post_like_path(like.post, like)
    end
    assert { response.redirect? }
    assert { response.location == new_user_session_url }
  end

  test "should not destroy like by other user" do
    like = post_likes(:one)

    sign_in @other_user

    delete post_like_path(like.post, like)
    assert { response.status == 404 }
    assert { PostLike.exists?(like.id) }
  end
end
