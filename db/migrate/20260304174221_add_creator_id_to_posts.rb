# frozen_string_literal: true

class AddCreatorIdToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :creator_id, :integer
    add_index :posts, :creator_id
    add_foreign_key :posts, :users, column: :creator_id
    
    reversible do |dir|
      dir.up do
        execute "UPDATE posts SET creator_id = user_id"
      end
    end
  end
end
