# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[8.1]
  def change
    create_table :users, if_not_exists: true do |t|
      t.string :email, null: false
      t.string :encrypted_password, default: "", null: false
      t.string :name
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.timestamps
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end

    create_table :categories, if_not_exists: true do |t|
      t.string :name
      t.timestamps
    end

    create_table :posts, if_not_exists: true do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end

    create_table :post_comments, if_not_exists: true do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :ancestry
      t.timestamps
      t.index :ancestry
    end

    create_table :post_likes, if_not_exists: true do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
      t.index [:user_id, :post_id], unique: true
    end
  end
end
