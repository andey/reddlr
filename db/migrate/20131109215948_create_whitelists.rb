class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.string :domain, null: false
      t.string :match
      t.string :replace
      t.integer :tumblr_type_id, null: false
      t.timestamps
    end
  end
end
