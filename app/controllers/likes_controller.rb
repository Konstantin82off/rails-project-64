# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = current_user.created_likes.build(post: @post)

    if @like.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @like = @post.post_likes.find_by(creator: current_user)

    if @like&.destroy
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".not_found")
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
