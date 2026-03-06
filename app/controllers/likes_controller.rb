# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.post_likes.build(user: current_user)

    if @like.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @like = @post.post_likes.find_by(user: current_user)

    if @like
      @like.destroy
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".not_found"), status: :not_found
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
