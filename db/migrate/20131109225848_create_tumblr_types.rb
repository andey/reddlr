class CreateTumblrTypes < ActiveRecord::Migration
  def change
    create_table :tumblr_types do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
