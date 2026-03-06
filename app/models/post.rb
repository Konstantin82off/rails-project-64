# frozen_string_literal: true

class Post < ApplicationRecord
  # Основные ассоциации
  belongs_to :creator, class_name: "User", inverse_of: :created_posts
  belongs_to :category, inverse_of: :posts

  # Временная ассоциация для обратной совместимости (удалим позже)
  belongs_to :user, optional: true, class_name: "User", foreign_key: "creator_id", inverse_of: :posts

  # Зависимости
  has_many :post_comments, dependent: :destroy, inverse_of: :post
  has_many :post_likes, dependent: :destroy, inverse_of: :post

  # Валидации
  validates :title, presence: true
  validates :body, presence: true
  validates :creator_id, presence: true

  # Методы для удобства
  def comments
    post_comments
  end

  def likes
    post_likes
  end

  def liked_by?(user)
    post_likes.exists?(creator_id: user.id)
  end

  # Временный метод для обратной совместимости
  def user
    creator
  end
end
