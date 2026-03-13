# app/models/post_like.rb
# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :likes_count

  validates :user_id, uniqueness: {
    scope: :post_id,
    message: ->(_record, _) { I18n.t('likes.errors.already_liked') }
  }
end
