# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @post.post_comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @comment.creator == current_user
      @comment.destroy
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".unauthorized")
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.post_comments.find(params[:id])
  end

  def comment_params
    params.expect(post_comment: %i[content ancestry])
  end
end
