class AddProcessedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :processed_at, :timestamp
  end
end
