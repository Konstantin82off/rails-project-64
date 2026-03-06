# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :created_posts, class_name: "Post", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy
  has_many :created_comments, class_name: "PostComment", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy
  has_many :created_likes, class_name: "PostLike", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy
end
