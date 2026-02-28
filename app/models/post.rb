# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: "user_id", inverse_of: :posts
  belongs_to :category

  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def liked_by?(user)
    post_likes.exists?(user: user)
  end
end
