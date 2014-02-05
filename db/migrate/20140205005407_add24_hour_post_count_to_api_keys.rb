class Add24HourPostCountToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :day_count, :integer, :default => 0
    add_column :api_keys, :historical_count, :integer, :default => 0
    add_column :api_keys, :enabled, :boolean, :default => true
  end
end
