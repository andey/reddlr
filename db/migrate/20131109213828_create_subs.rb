class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
