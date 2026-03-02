# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = current_user.post_likes.build(post: @post)

    if @like.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".error")
    end
  end

  def destroy
    @like = current_user.post_likes.find_by!(post: @post)
    @like.destroy
    redirect_to @post, notice: t(".success")
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
