# frozen_string_literal: true

class PostComment < ApplicationRecord
  # Основные ассоциации
  belongs_to :creator, class_name: "User", inverse_of: :created_comments
  belongs_to :post, inverse_of: :post_comments

  # Временная ассоциация для обратной совместимости
  belongs_to :user, optional: true, class_name: "User", foreign_key: "creator_id"

  has_ancestry

  validates :content, presence: true
  validates :creator_id, presence: true

  # Временный метод для обратной совместимости
  def user
    creator
  end
end
