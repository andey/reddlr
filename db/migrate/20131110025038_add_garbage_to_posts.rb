class AddGarbageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :garbage, :boolean
  end
end
