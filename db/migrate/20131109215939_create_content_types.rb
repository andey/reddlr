class CreateContentTypes < ActiveRecord::Migration
  def change
    create_table :content_types do |t|
      t.string :name, null: false, unique: true
      t.string :tumblr_type_id, null: false
      t.timestamps
    end
  end
end
