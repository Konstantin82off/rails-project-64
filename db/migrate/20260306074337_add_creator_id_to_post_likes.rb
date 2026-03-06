# frozen_string_literal: true

class AddCreatorIdToPostLikes < ActiveRecord::Migration[8.1]
  def change
    add_column :post_likes, :creator_id, :integer
    add_index :post_likes, :creator_id
    add_foreign_key :post_likes, :users, column: :creator_id
    
    # Копируем данные из user_id в creator_id
    reversible do |dir|
      dir.up do
        execute "UPDATE post_likes SET creator_id = user_id"
      end
    end
    
    # Делаем creator_id NOT NULL
    change_column_null :post_likes, :creator_id, false
  end
end
