# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_likes
  belongs_to :post, inverse_of: :post_likes

  validates :creator_id, uniqueness: { scope: :post_id }
end
