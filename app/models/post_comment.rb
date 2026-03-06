# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_comments
  belongs_to :post, inverse_of: :post_comments

  has_ancestry

  validates :content, presence: true

  def parent_id
    return nil if ancestry.blank?

    parts = ancestry.split("/")
    parts.last.to_i
  end
end
