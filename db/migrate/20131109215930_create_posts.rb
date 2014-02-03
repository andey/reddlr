class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :reddit_id, null: false, unique: true
      t.string :title, null: false
      t.integer :sub_id, null: false, unique: true
      t.string :tumblr_id
      t.integer :content_type_id
      t.timestamp :submitted_at
      t.timestamps
    end
  end
end
