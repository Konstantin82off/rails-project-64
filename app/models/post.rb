# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id", inverse_of: :posts
  belongs_to :category, inverse_of: :posts
  has_many :post_comments, dependent: :destroy, inverse_of: :post
  has_many :post_likes, dependent: :destroy, inverse_of: :post

  alias_attribute :user, :creator
  alias_attribute :comments, :post_comments
  alias_attribute :likes, :post_likes

  validates :title, presence: true
  validates :body, presence: true

  def liked_by?(user)
    post_likes.exists?(user: user)
  end
end
