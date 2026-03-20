# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.includes(:creator, :category).order(created_at: :desc)
  end

  def show
    authenticate_user!
    @post = Post.find(params[:id])
    @comments = @post.comments.roots.order(created_at: :desc).includes(:user)
    @comment = PostComment.new
  end

  def new
    authenticate_user!
    @post = Post.new
    @categories = Category.all
  end

  def create
    authenticate_user!
    @post = current_user.created_posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      @categories = Category.all
      render :new, status: :unprocessable_content
    end
  end

  private

  def post_params
    params.expect(post: %i[title body category_id])
  end
end
