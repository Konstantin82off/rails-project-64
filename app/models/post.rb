# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_posts
  belongs_to :category, inverse_of: :posts

  has_many :comments, class_name: "PostComment", dependent: :destroy, inverse_of: :post
  has_many :likes, class_name: "PostLike", dependent: :destroy, inverse_of: :post

  validates :title, presence: true
  validates :body, presence: true

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
