# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

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
    @comment = @post.post_comments.find_by(id: params[:id])

    if @comment.nil? || @comment.user != current_user
      return redirect_to @post, alert: t(".unauthorized")
    end

    @comment.destroy
    redirect_to @post, notice: t(".success")
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.expect(post_comment: %i[content parent_id])
  end
end
