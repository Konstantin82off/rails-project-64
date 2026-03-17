# frozen_string_literal: true

class AddCheckConstraintToPostsLikesCount < ActiveRecord::Migration[8.1]
  def change
    # Добавляем проверку на уровне базы данных, что likes_count не может быть отрицательным
    execute <<-SQL
      ALTER TABLE posts
      ADD CONSTRAINT likes_count_non_negative
      CHECK (likes_count >= 0);
    SQL
  end
end
