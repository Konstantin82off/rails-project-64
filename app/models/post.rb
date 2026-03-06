# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_posts
  belongs_to :category, inverse_of: :posts

  has_many :post_comments, dependent: :destroy, inverse_of: :post
  has_many :post_likes, dependent: :destroy, inverse_of: :post

  validates :title, presence: true
  validates :body, presence: true

  def comments
    post_comments
  end

  def likes
    post_likes
  end

  def liked_by?(user)
    post_likes.exists?(creator_id: user.id)
  end
end
