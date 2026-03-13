# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_creator!, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:creator, :category).order(created_at: :desc)
  end

  def show
    @comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.created_posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: t('.success')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_creator!
    return if @post.creator == current_user

    redirect_to posts_url, alert: t('.unauthorized')
  end

  def post_params
    params.expect(post: %i[title body category_id])
  end
end
