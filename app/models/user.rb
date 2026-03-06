# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Ассоциации для созданных постов, комментариев и лайков
  has_many :created_posts, class_name: "Post", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy
  has_many :created_comments, class_name: "PostComment", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy
  has_many :created_likes, class_name: "PostLike", foreign_key: "creator_id", inverse_of: :creator, dependent: :destroy

  # Ассоциации для пользователя (оставляем для обратной совместимости)
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy, inverse_of: :user
  has_many :post_likes, dependent: :destroy, inverse_of: :user

  def creator
    self
  end
end
