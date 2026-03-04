# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy, inverse_of: :user
  has_many :post_likes, dependent: :destroy, inverse_of: :user

  def creator
    self
  end
end
