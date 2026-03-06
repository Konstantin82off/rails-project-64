# frozen_string_literal: true

class RemoveUserIdFromPosts < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :posts, :users if foreign_key_exists?(:posts, :users)
    remove_index :posts, :user_id if index_exists?(:posts, :user_id)
    remove_column :posts, :user_id, :integer
    
    change_column_null :posts, :creator_id, false
  end
end