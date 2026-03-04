# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts
  belongs_to :creator, class_name: "User", optional: true, inverse_of: :posts
  belongs_to :category, inverse_of: :posts
  has_many :post_comments, dependent: :destroy, inverse_of: :post
  has_many :post_likes, dependent: :destroy, inverse_of: :post

  before_validation :set_user_from_creator, if: -> { creator_id.present? && user_id.nil? }
  before_validation :set_creator_from_user, if: -> { user_id.present? && creator_id.nil? }
  before_save :sync_ids

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

  def set_user_from_creator
    self.user_id = creator_id
  end

  def set_creator_from_user
    self.creator_id = user_id
  end

  def sync_ids
    self.creator_id = user_id if creator_id.nil?
    self.user_id = creator_id if user_id.nil?
  end
end
