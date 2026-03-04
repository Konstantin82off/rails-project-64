# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user, inverse_of: :post_comments
  belongs_to :post, inverse_of: :post_comments
  has_ancestry

  validates :content, presence: true
end
