# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.includes(:creator, :category).order(created_at: :desc)
  end

  def show
    @comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.created_posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.expect(post: %i[title body category_id])
  end
end
