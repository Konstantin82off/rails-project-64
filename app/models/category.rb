# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: true,
                   length: { minimum: 2, maximum: 100 }

  def to_s
    name
  end
end
