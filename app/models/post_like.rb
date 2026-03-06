# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user, inverse_of: :likes
  belongs_to :post, inverse_of: :likes

  validates :user_id, uniqueness: { scope: :post_id }
end
