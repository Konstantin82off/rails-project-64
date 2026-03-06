# frozen_string_literal: true

class AddCreatorIdToPostComments < ActiveRecord::Migration[8.1]
  def change
    add_column :post_comments, :creator_id, :integer
  end
end
