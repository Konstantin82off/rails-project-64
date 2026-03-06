# frozen_string_literal: true

class FixSchemaForRender < ActiveRecord::Migration[8.1]
  def change
    # Добавляем недостающие поля в post_comments
    unless column_exists?(:post_comments, :user_id)
      add_column :post_comments, :user_id, :integer
      add_index :post_comments, :user_id
      add_foreign_key :post_comments, :users, column: :user_id
    end

    # Добавляем недостающие поля в post_likes
    unless column_exists?(:post_likes, :user_id)
      add_column :post_likes, :user_id, :integer
      add_index :post_likes, :user_id
      add_foreign_key :post_likes, :users, column: :user_id
    end

    # Добавляем недостающие поля в posts
    unless column_exists?(:posts, :creator_id)
      add_column :posts, :creator_id, :integer
      add_index :posts, :creator_id
      add_foreign_key :posts, :users, column: :creator_id
    end

    # Добавляем уникальный индекс для post_likes
    unless index_exists?(:post_likes, [:user_id, :post_id])
      add_index :post_likes, [:user_id, :post_id], unique: true
    end

    # Добавляем ancestry индекс для post_comments
    unless index_exists?(:post_comments, :ancestry)
      add_index :post_comments, :ancestry
    end
  end
end
