class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.string :name, null: false
      t.string :regex, null: false
      t.integer :tumblr_type_id, null: false
      t.timestamps
    end
  end
end
