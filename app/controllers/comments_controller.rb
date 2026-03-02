# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @comment = @post.post_comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".error")
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: t(".success")
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.post_comments.find(params[:id])
  end

  def authorize_user!
    return if @comment.user == current_user

    redirect_to @post, alert: t(".unauthorized")
  end

  def comment_params
    params.expect(post_comment: %i[content parent_id])
  end
end
