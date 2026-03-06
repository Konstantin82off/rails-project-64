# frozen_string_literal: true

class CleanupUserIdColumns < ActiveRecord::Migration[8.1]
  def up
    # Сначала удаляем внешние ключи
    remove_foreign_key :post_comments, :users if foreign_key_exists?(:post_comments, :users)
    remove_foreign_key :post_likes, :users if foreign_key_exists?(:post_likes, :users)
    remove_foreign_key :posts, :users if foreign_key_exists?(:posts, :users)
    
    # Удаляем индексы
    remove_index :post_comments, :user_id if index_exists?(:post_comments, :user_id)
    remove_index :post_likes, :user_id if index_exists?(:post_likes, :user_id)
    remove_index :posts, :user_id if index_exists?(:posts, :user_id)
    
    # Теперь удаляем колонки
    remove_column :post_comments, :user_id if column_exists?(:post_comments, :user_id)
    remove_column :post_likes, :user_id if column_exists?(:post_likes, :user_id)
    remove_column :posts, :user_id if column_exists?(:posts, :user_id)
    
    # Делаем creator_id NOT NULL
    change_column_null :post_comments, :creator_id, false
    change_column_null :post_likes, :creator_id, false
    change_column_null :posts, :creator_id, false
  end

  def down
    # Восстанавливаем колонки (только если их нет)
    add_column :posts, :user_id, :integer unless column_exists?(:posts, :user_id)
    add_column :post_comments, :user_id, :integer unless column_exists?(:post_comments, :user_id)
    add_column :post_likes, :user_id, :integer unless column_exists?(:post_likes, :user_id)
  end
end
