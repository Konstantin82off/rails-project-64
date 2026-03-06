# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :created_posts, class_name: "Post", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy
  has_many :post_comments, inverse_of: :user, dependent: :destroy
  has_many :post_likes, inverse_of: :user, dependent: :destroy
end
