# app/models/category.rb
# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
