class ChangeTumblrTypeIdType < ActiveRecord::Migration
  def change
    change_column :content_types, :tumblr_type_id, 'integer USING CAST(tumblr_type_id AS integer)'
  end
end
