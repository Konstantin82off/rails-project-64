# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    authenticate_user!
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    authenticate_user!
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".unauthorized")
    end
  end

  private

  def comment_params
    params.expect(post_comment: %i[content parent_id])
  end
end
