# app/models/post.rb
# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true
end
