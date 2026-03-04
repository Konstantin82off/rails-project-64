# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_like, only: [:destroy]

  def create
    @like = current_user.post_likes.build(post: @post)

    if @like.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".error")
    end
  end

  def destroy
    raise ActiveRecord::RecordNotFound unless @like.user == current_user

    @like.destroy
    redirect_to @post, notice: t(".success")
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = PostLike.find(params[:id])
  end
end
