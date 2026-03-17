# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user, inverse_of: :comments
  belongs_to :post, inverse_of: :comments

  has_ancestry orphan_strategy: :restrict

  validates :content, presence: true,
                      length: { minimum: 2, maximum: 1000 }
end
