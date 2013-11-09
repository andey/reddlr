class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :username, null: false, unique: true
      t.timestamps
    end
  end
end
