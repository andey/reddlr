class AddUrlMatchToContentType < ActiveRecord::Migration
  def change
    add_column :content_types, :url_match, :string
  end
end
