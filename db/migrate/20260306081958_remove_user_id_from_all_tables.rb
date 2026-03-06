# frozen_string_literal: true

class RemoveUserIdFromAllTables < ActiveRecord::Migration[8.1]
  def change
    # Удаляем из post_comments
    remove_foreign_key :post_comments, :users if foreign_key_exists?(:post_comments, :users)
    remove_index :post_comments, :user_id if index_exists?(:post_comments, :user_id)
    remove_column :post_comments, :user_id, :integer
    
    # Удаляем из post_likes
    remove_foreign_key :post_likes, :users if foreign_key_exists?(:post_likes, :users)
    remove_index :post_likes, :user_id if index_exists?(:post_likes, :user_id)
    remove_column :post_likes, :user_id, :integer
    
    # Удаляем из posts
    remove_foreign_key :posts, :users if foreign_key_exists?(:posts, :users)
    remove_index :posts, :user_id if index_exists?(:posts, :user_id)
    remove_column :posts, :user_id, :integer
    
    # Делаем creator_id NOT NULL во всех таблицах
    change_column_null :post_comments, :creator_id, false
    change_column_null :post_likes, :creator_id, false
    change_column_null :posts, :creator_id, false
  end
end
