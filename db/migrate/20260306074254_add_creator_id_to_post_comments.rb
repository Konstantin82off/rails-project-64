# frozen_string_literal: true

class AddCreatorIdToPostComments < ActiveRecord::Migration[8.1]
  def change
    add_column :post_comments, :creator_id, :integer
    add_index :post_comments, :creator_id
    add_foreign_key :post_comments, :users, column: :creator_id
    
    # Копируем данные из user_id в creator_id
    reversible do |dir|
      dir.up do
        execute "UPDATE post_comments SET creator_id = user_id"
      end
    end
    
    # Делаем creator_id NOT NULL
    change_column_null :post_comments, :creator_id, false
  end
end
