# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :nullify, inverse_of: :category
end
