class AddRemovedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :removed_at, :timestamp
  end
end
