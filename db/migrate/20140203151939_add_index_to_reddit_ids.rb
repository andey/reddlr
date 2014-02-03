class AddIndexToRedditIds < ActiveRecord::Migration
  def change
    add_index :posts, :reddit_id, unique: true
  end
end
