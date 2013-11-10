class AddWhitelistToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :whitelist_id, :integer
  end
end
