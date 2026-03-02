# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user, :category).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t(".success")
    else
      @categories = Category.all
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t(".success")
    else
      @categories = Category.all
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: t(".success")
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to posts_url, alert: t(".unauthorized") unless @post.user == current_user
  end

  def post_params
    params.expect(post: %i[title body category_id])
  end
end
