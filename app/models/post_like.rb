# frozen_string_literal: true

class PostLike < ApplicationRecord
  # Основные ассоциации
  belongs_to :creator, class_name: "User", inverse_of: :created_likes
  belongs_to :post, inverse_of: :post_likes

  # Временная ассоциация для обратной совместимости
  belongs_to :user, optional: true, class_name: "User", foreign_key: "creator_id"

  validates :creator_id, uniqueness: { scope: :post_id }

  # Временный метод для обратной совместимости
  def user
    creator
  end
end
