class SaveTheTumblrResponses < ActiveRecord::Migration
  def up
    add_column :posts, :response, :hstore
  end

  def down
    remove_column :posts, :response
  end
end