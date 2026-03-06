# frozen_string_literal: true

class RemoveUserIdFromPostsAgain < ActiveRecord::Migration[8.1]
  def up
    remove_foreign_key :posts, :users if foreign_key_exists?(:posts, :users)
    remove_index :posts, :user_id if index_exists?(:posts, :user_id)
    remove_column :posts, :user_id, :integer
    
    change_column_null :posts, :creator_id, false
    
    add_foreign_key :posts, :users, column: :creator_id
  end

  def down
    add_column :posts, :user_id, :integer, null: false
    add_index :posts, :user_id
    add_foreign_key :posts, :users, column: :user_id
    
    change_column_null :posts, :creator_id, true
  end
end