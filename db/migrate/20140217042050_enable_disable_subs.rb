class EnableDisableSubs < ActiveRecord::Migration
  def change
    add_column :subs, :enabled, :boolean, default: true
  end
end
