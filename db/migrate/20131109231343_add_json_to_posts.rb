class AddJsonToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :json, :hstore
  end

  def down
    remove_column :posts, :json
  end
end
