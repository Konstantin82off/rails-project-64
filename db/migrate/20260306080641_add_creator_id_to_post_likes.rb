# frozen_string_literal: true

class AddCreatorIdToPostLikes < ActiveRecord::Migration[8.1]
  def change
    add_column :post_likes, :creator_id, :integer
  end
end
