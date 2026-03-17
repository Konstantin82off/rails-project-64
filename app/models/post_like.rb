# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :likes_count

  validates :user_id, uniqueness: {
    scope: :post_id,
    message: ->(_record, _) { I18n.t('likes.errors.already_liked') }
  }

  # Добавляем валидацию для предотвращения отрицательных лайков
  validate :likes_count_cannot_be_negative, if: -> { post.present? }

  private

  def likes_count_cannot_be_negative
    return unless post.likes_count.negative?

    errors.add(:base, 'Количество лайков не может быть отрицательным')
  end
end
