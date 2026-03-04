# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :creator, class_name: "User", optional: true
  belongs_to :category, inverse_of: :posts
  has_many :post_comments, dependent: :destroy, inverse_of: :post
  has_many :post_likes, dependent: :destroy, inverse_of: :post

  before_save :sync_creator_with_user
  before_create :sync_creator_with_user

  def comments
    post_comments
  end

  def likes
    post_likes
  end

  validates :title, presence: true
  validates :body, presence: true

  def liked_by?(user)
    post_likes.exists?(user: user)
  end

  private

  def sync_creator_with_user
    self.creator_id = user_id if creator_id.nil?
  end
end
