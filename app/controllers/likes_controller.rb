# app/controllers/likes_controller.rb
# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    authenticate_user!

    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    authenticate_user!

    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    if @like
      @like.destroy
      redirect_to @post, notice: t(".success")
    else
      redirect_to @post, alert: t(".not_found")
    end
  end
end
